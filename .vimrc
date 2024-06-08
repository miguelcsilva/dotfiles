" General
set number 			        " Show line numbers
set relativenumber		    " Show relative line numbers
set wrap			        " Wrap long lines
set encoding=utf-8		    " Default encoding is latin1: https://vi.stackexchange.com/a/17326
set wildmenu			    " Show menu autocomplete on <tab>
set showmatch		        " Highlights matching parentheses / brackets: [{()}]
set laststatus=2		    " Always show status bar
set ruler			        " Show line and column number in status bar

" Syntax and file types
syntax enable			    " Enables syntax highlighting
filetype plugin on		    " Loads plugin for specify file type
filetype indent on		    " Loads indent for specify file type

" Tab
set tabstop=4			    " Number of spaces to display <tab> as
set expandtab			    " Convert <tab> keypress to spaces
set shiftwidth=4 		    " Number of spaces to use for each step of auto-indent 
set softtabstop=4		    " Number of spaces to remove after pressing backspace on <tab>
set autoindent			    " Copy indent from current line when starting a new line
set smartindent			    " Improved autoindent for brackets: {}

" Search
set incsearch			    " Search as characters are entered
set hlsearch			    " Highligh search matches

" Scheme
colorscheme material		" Use custom theme

" Cursor
let &t_SI = "\<esc>[5 q" 	" I beam cursor for insert mode
let &t_EI = "\<esc>[2 q" 	" Block cursor for normal mode
let &t_SR = "\<esc>[3 q" 	" Underline cursor for replace mode

