#! /bin/bash
export INSTALL_LOG="$HOME/.startup.log"

echo "Installing mosh..." >> $INSTALL_LOG
sudo apt-get update && sudo apt-get install -y mosh

echo "Installing essential apps with apt-get..." >> $INSTALL_LOG
sudo apt-get update && sudo apt-get install -y \
    build-essential \
    apt-transport-https \
    ca-certificates \
    curl \
    entr \
    git \
    libssl-dev \
    make \
    pandoc \
    software-properties-common \
    tmux \
    unzip \
    xclip

echo "Installing Docker..." >> $INSTALL_LOG
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
sudo apt-get update && sudo apt-get install -y docker-ce

echo "Installing ZSH..." >> $INSTALL_LOG
sudo apt-get update && sudo apt-get install -y zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sudo zsh
sudo chsh -s /usr/bin/zsh $USER
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing Miniconda..." >> $INSTALL_LOG
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
sudo bash ~/miniconda.sh -b -p /opt/anaconda && sudo rm ~/miniconda.sh
sudo chown -R $USER /opt/anaconda/
export PATH="/opt/anaconda/bin:$PATH"
pip install --upgrade pip

echo "Setting up Git..." >> $INSTALL_LOG
git config --global user.email "anthony.kusumo.khong@gmail.com"
git config --global user.name "Anthony Khong"
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install -y git-lfs
git lfs install

echo "Configuring dotfiles..." >> $INSTALL_LOG
cd $HOME/dotfiles \
    && git submodule init \
    && git submodule update \
    && cd $HOME \
    && /bin/bash -c "source ~/dotfiles/bash/bashrc" \
    && /bin/bash $HOME/dotfiles/bash/recreate_symbolic_links

echo "Installing Neovim + dependencies..." >> $INSTALL_LOG
pip install --upgrade neovim jedi google-api-python-client pyflakes mypy
sudo add-apt-repository -y ppa:neovim-ppa/stable \
        && sudo apt-get update \
        && sudo apt-get install -y neovim \
        && /bin/bash $HOME/dotfiles/tmux/tpm/scripts/install_plugins.sh
sudo chown -R $USER "$HOME/.local"
# nvim +PlugInstall +silent +qall

echo "Installing Emacs and its dependencies..." >> $INSTALL_LOG
sudo add-apt-repository ppa:kelleyk/emacs -y \
    && sudo apt-get update \
    && sudo apt install -y emacs26
emacs26 --daemon &

echo "Installing Ripgrep..." >> $INSTALL_LOG
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
sudo dpkg -i ripgrep_0.10.0_amd64.deb && rm ripgrep_0.10.0_amd64.deb

echo "Installing Parinfer..." >> $INSTALL_LOG
curl https://sh.rustup.rs -sSf | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"
cd ~/dotfiles/vim/plugged/parinfer-rust \
    && make install \
    && cargo build --release \
    && cargo install --force \
    && cd $HOME

echo "Installing Tmate..." >> $INSTALL_LOG
curl -LO https://github.com/tmate-io/tmate/releases/download/2.2.1/tmate-2.2.1-static-linux-amd64.tar.gz
sudo tar -xvf tmate-2.2.1-static-linux-amd64.tar.gz
sudo mv tmate-2.2.1-static-linux-amd64/tmate /usr/bin
sudo rm -rf tmate-2.2.1-static-linux-amd64
sudo rm tmate-2.2.1-static-linux-amd64.tar.gz

echo "Setting up permissions and Docker..." >> $INSTALL_LOG
sudo chown -R $USER $HOME
cd $HOME/dotfiles \
    && git checkout . \
    && cd $HOME
sudo usermod -a -G docker $USER
sudo usermod -aG sudo $USER

# echo "Creating 32G of swap file..." >> $INSTALL_LOG
# sudo fallocate -l 32G /swapfile
# sudo chmod 600 /swapfile
# sudo mkswap /swapfile
# sudo swapon /swapfile
# sudo cp /etc/fstab /etc/fstab.bak
# echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

echo "Installing Xorg.." >> $INSTALL_LOG
sudo apt-get -y install xorg openbox

echo "Setup complete!" >> $INSTALL_LOG
