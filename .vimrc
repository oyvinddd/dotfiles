" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Show line numbers
set number
set numberwidth=4

set tabstop=4
set shiftwidth=4
set expandtab

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on
syntax on

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
" set cursorcolumn

" Ignore capital letters during search
set ignorecase

" Show partial command you type in the last line of the screen
set showcmd
