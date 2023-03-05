-- Source: https://raw.githubusercontent.com/arusahni/dotfiles/fd6bf6435763f6d29e95ec3c42cdc33aa2cf6952/nvim/lua/plugins.lua

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

vim.cmd [[packadd packer.nvim]]

return require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"

    -- Utilities
    use 'nvim-lua/plenary.nvim'

		-- Appearance
		use 'airblade/vim-gitgutter'
		use 'ayu-theme/ayu-vim'

    -- Editing
    use 'junegunn/vim-easy-align'
    use 'scrooloose/nerdcommenter'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'

    -- Tmux
    use 'christoomey/vim-tmux-navigator'
    use 'jpalardy/vim-slime'

    -- IDE
    use 'neovim/nvim-lspconfig'
    use "lukas-reineke/lsp-format.nvim"
    use 'sheerun/vim-polyglot'
    use 'nvim-treesitter/nvim-treesitter'
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'
    use 'j-hui/fidget.nvim'
    use 'nvim-tree/nvim-tree.lua'

    -- FZF
    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use { 'junegunn/fzf.vim' }

    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    -- Snippets
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-vsnip'

    -- Rust
    use 'rust-lang/rust.vim'
    use 'simrat39/rust-tools.nvim'

    -- JavaScript and TypeScript
    use 'leafgarland/typescript-vim'
    use 'maxmellon/vim-jsx-pretty'
    use 'pangloss/vim-javascript'

    -- Others
    use 'ekalinin/Dockerfile.vim'
    use 'plasticboy/vim-markdown'
    use 'kevinoid/vim-jsonc'
    use 'jidn/vim-dbml'

    if packer_bootstrap then
      require("packer").sync()
    end
  end
}