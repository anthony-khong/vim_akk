" This is the remote vimrc. The local vimrc should include the following:
" set runtimepath^=~/Dropbox/dotfiles/vim
" source ~/Dropbox/dotfiles/vim/vimrc
" NOTE: jedi-vim must be installed in the local machine!

" For tmux colour compatibility
set term=screen-256color

" Disable folding so that the key 'f' can be used for movement
set nofoldenable

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
"==========================================================================="
" Key Remaps                                                                "
"==========================================================================="
let mapleader = ","
nmap <Space> ,

" Five line buffer
set so=5

" Save current script
nnoremap <Leader>s :update<CR>

" Remove trailing whitespace
:nnoremap <silent> <C-w> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Will's equals sign idea
nnoremap <Leader>= i<del><space><esc>gelcw<space>=<space><esc>

" Page up and down, then centers the cursor
" nnoremap = <S-Up>zz
" nnoremap \ <S-Down>zz
" vnoremap = <S-Up>zz
" vnoremap \ <S-Down>zz
noremap <C-u> <S-Up>zz
noremap <C-d> <S-Down>zz

" Centers screen after jumping to mark???
map <expr> M printf('`%c zz',getchar())
map <expr> M printf('\'%c zz',getchar())

nnoremap G Gzz
:nnoremap n nzz
:nnoremap N Nzz

" Split pane horizontally
nnoremap <Leader>v <C-w>v
" Move between panes
nnoremap <Leader>z <C-w>w

" Jumping between tabs
map <Leader>, <esc>:tabprevious<CR>
map <Leader>. <esc>:tabnext<CR>
" Close current tab
nnoremap <Leader>' :q<CR>

" Jump to escape mode
ino hh <esc>
ino kk <esc>
ino jj <esc>

" Moving between search hits
inoremap <Leader>n <C-n>
" inoremap <Leader>p <C-p>
" Turn off search highlights
nnoremap <C-x> :nohlsearch<CR>

" Copy the entire script to the clipboard
nnoremap <Leader>l mwggVG"+y'wzz
" Copy from current line to the top
nnoremap <Leader>k mwggV'w"+y'wzz
" Copy from current line to the bottom
nnoremap <Leader>j mwGV'w"+y'wzz
" Copy entire line to the clipboard
nnoremap <Leader>y V"+y
" Copy selection to the clipboard
vnoremap <Leader>c "+y

" Moving up and down physical lines - useful for .txt/.md editing
nnoremap j gj
nnoremap k gk

" Run current Python script
nnoremap <Leader><Space> :!ipython -i %<CR>
" Python shortcuts
map <Leader>t Oimport pdb; pdb.set_trace() # BREAKPOINT<C-c>
map <Leader>m Oimport matplotlib.pyplot as plt<C-c>

" Get a line of #'s
nnoremap <Leader>3 i#<esc>78.b

" If Markdown, don't include line break after 80 characters
" Source: https://www.piware.de/2014/07/vim-config-for-markdownlatex-pandoc-editing/
function s:md_settings()
    " inoremap <buffer> <Leader>n \note[item]{}<Esc>i
    " noremap <buffer> <Leader>b :! pandoc -t beamer % -o %<.pdf<CR><CR>
    " noremap <buffer> <Leader>l :! pandoc -t latex % -o %<.pdf<CR>
    " noremap <buffer> <Leader>v :! evince %<.pdf 2>&1 >/dev/null &<CR><CR>

    " adjust syntax highlighting for LaTeX parts
    "   inline formulas:
    " syntax region Statement oneline matchgroup=Delimiter start="\$" end="\$"
    "   environments:
    " syntax region Statement matchgroup=Delimiter start="\\begin{.*}" end="\\end{.*}" contains=Statement
    "   commands:
    " syntax region Statement matchgroup=Delimiter start="{" end="}" contains=Statement
    nnoremap <buffer> <Leader>p :!pandoc -V geometry:margin=2cm -o "%:r.pdf" %<CR><CR>
endfunction
autocmd BufRead,BufNewFile *.md setfiletype markdown
autocmd FileType markdown :call <SID>md_settings()
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
au BufNewFile,BufFilePre,BufRead *.md set textwidth=0
au BufNewFile,BufFilePre,BufRead *.md set colorcolumn=0
au BufNewFile,BufFilePre,BufRead *.md set noexpandtab
au BufNewFile,BufRead,BufEnter *.md :syn match markdownIgnore "\$.*_.*\$"
au BufNewFile,BufFilePre,BufRead *.md set wrap

" Enbale CUDA syntax
au BufNewFile,BufRead *.cu set ft=cu
au BufNewFile,BufRead *.cuh set ft=cu

"==========================================================================="
" Sample .vimrc file by Martin Brochhaus                                    "
" Presented at PyCon APAC 2012                                              "
" (https://github.com/mbrochh/vim-as-a-python-ide)                          "
"==========================================================================="

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>
set clipboard=unnamed

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
"" map <c-j> <c-w>j
"" map <c-k> <c-w>k
"" map <c-l> <c-w>l
"" map <c-h> <c-w>h

" map sort function to a key
"" vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
colorscheme wombat256mod

" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
au BufNewFile,BufFilePre,BufRead *.py set colorcolumn=80
au BufNewFile,BufFilePre,BufRead *.py highlight ColorColumn ctermbg=233

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()

" =========================================================================="
" Python IDE Setup                                                          "
" =========================================================================="

" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2

" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
let g:jedi#usages_command = "<leader>;"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#completions_command = "<Leader>c"
let g:jedi#smart_auto_mappings = 0
" let g:jedi#show_call_signatures = 1

" indentLine configs
let g:indentLine_enabled = 1
let g:indentLine_color_term = 237
" let g:indentLine_char = '︙'

" Make supertab scroll from top to bottom
let g:SuperTabDefaultCompletionType = "<c-n>"

" Make ctrlp open a new tab by default
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Set EasyMotion trigger
map <Leader> <Plug>(easymotion-prefix)
map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)
map <Leader>f <Plug>(easymotion-f)
map <Leader>F <Plug>(easymotion-F)

" Syntastic configs
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=1
highlight SyntasticWarning NONE
highlight SyntasticError NONE
