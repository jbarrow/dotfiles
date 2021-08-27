" Disable compatibility with vi
set nocompatible

" Enable filetype detection
filetype on

" Enable plugins and load plugin for the detected file type
filetype plugin on

" Load an indent file for the detected file type
filetype indent on

" Turn syntax highlighting on
syntax on

" Add numbers to the left-hand side
set number

" Highlight the cursor line
set cursorline
hi CursorLine cterm=none ctermbg=8 
hi CursorLineNr cterm=none ctermbg=8 ctermfg=15

hi LineNr guifg=#050505 ctermfg=grey
set nuw=6
" 8 = dark gray, 15 = white 
" set cursorcolumn

" Set shift width to 4 spaces
set shiftwidth=4

" Set tab width to 4 columns
set tabstop=4

" Use space characters instead of tabs
set expandtab

" Do not save backup files
set nobackup

" Limit scroll count
set scrolloff=10

" Do not wrap lines
set nowrap

" Incrementally highlight matching characters
set incsearch

" Ignore case while searching
set ignorecase

" Overwrite ignorecase if searching with capital letters
set smartcase

" Show partial command in the las tline of the screen
set showcmd

" Show the mode
set showmode

" Show matching words during a search
set showmatch

" Use highlighting when doing a search
set hlsearch

" Set the commands history tp a larger buffer
set history=1000

" Enable auto completion menu after pressing tab
set wildmenu

" Make wildmenu behave more like Bash completion
set wildmode=list:longest

" Ignore files we don't want to edit with Vim:
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx


