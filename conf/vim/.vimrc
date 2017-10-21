" encodeing
set encoding=utf-8
set fenc=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
scriptencoding utf-8 


" View
syntax on
set showcmd
set title
set ruler
set number
set cursorline
set showmatch
set wrap
set t_Co=256
set colorcolumn=80
set mouse=a

" The color theme

" colorscheme monokai
" colorscheme srcery
" colorscheme hacked_ayu
colorscheme happy_hacking
" colorscheme idle 
" colorscheme buddy 
" colorscheme idle 
" colorscheme maui

" indent
set smartindent
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=2
set autoindent
set smartindent
set backspace=indent,eol,start

" search
set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan

" Nerd tree
map <C-g> :NERDTreeToggle<CR>
