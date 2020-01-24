set termguicolors
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 

set nocompatible
set shell=$SHELL

" Allow backgrounding buffers without writing them, and remember marks/undo
set hidden

" Remember more commands and search history
set history=1000

" Make tab completion for files/buffers act like bash
set wildmenu

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
set wildignore=*.gif,*.jpg,*.png,*.o,*.obj,.git,.svn,tmp

" Unfold by default
set foldlevel=10

let mapleader=","
set clipboard=unnamed 

" Indenting ********************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent  (local to buffer)

" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

" Searching *******************************************************************
set hlsearch " highlight search
set incsearch " incremental search, search as you type
set ignorecase " Ignore case when searching
set smartcase " Ignore case when searching lowercase

" incremental command live feedback
set inccommand=nosplit

" Wrapping and Scrolling ******************************************************
set nowrap
set linebreak " Wrap at word
set scrolloff=4
set sidescrolloff=4

" Set list Chars - for showing characters that are not
" normally displayed i.e. whitespace, tabs, EOL
set listchars=trail:·,tab:‣\ ,extends:,precedes:,nbsp:␣
set list
nmap <silent> <leader>s :set nolist!<CR>

" Spaces, not tabs
set softtabstop=2
set shiftwidth=2
set shiftround
set tabstop=2
set expandtab
set smarttab " a <Tab> in an indent inserts 'shiftwidth' spaces

" Sessions ********************************************************************
" Sets what is saved when you save a session (:mksession path/to/session.vim)
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

" Misc ************************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
" set visualbell t_vb= " Turn off the bell, this could be more annoying, but I'm not sure how

" Reload the file when it has been chaged outside of vim
set autoread

" Speed up large files
let g:LargeFile = 64
set synmaxcol=512                   " max colored lines in line

set lazyredraw

filetype plugin indent on
