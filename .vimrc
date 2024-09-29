" General
set number 			        " Show line numbers
set relativenumber		    " show relative line numbers
set wrap			        " wrap long lines
set encoding=utf-8		    " default encoding is latin1: https://vi.stackexchange.com/a/17326
set wildmenu			    " show menu autocomplete on <tab>
set showmatch		        " highlights matching parentheses / brackets: [{()}]
set laststatus=2		    " always show status bar
set ruler			        " show line and column number in status bar

" syntax and file types
syntax enable			    " enables syntax highlighting
filetype plugin on		    " loads plugin for specify file type
filetype indent on		    " loads indent for specify file type

" tab
set tabstop=4			    " number of spaces to display <tab> as
set expandtab			    " convert <tab> keypress to spaces
set shiftwidth=4 		    " number of spaces to use for each step of auto-indent 
set softtabstop=4		    " number of spaces to remove after pressing backspace on <tab>
set autoindent			    " copy indent from current line when starting a new line
set smartindent			    " improved autoindent for brackets: {}

" search
set incsearch			    " search as characters are entered
set hlsearch			    " highligh search matches

" Cursor
let &t_SI = "\<esc>[5 q" 	" I beam cursor for insert mode
let &t_EI = "\<esc>[2 q" 	" Block cursor for normal mode
let &t_SR = "\<esc>[3 q" 	" Underline cursor for replace mode

" Remaps
inoremap jk <esc>
vnoremap y y'>
