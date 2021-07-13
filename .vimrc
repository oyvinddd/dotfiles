syntax on

set t_Co=256
set tabstop=8
set expandtab
set shiftwidth=4
set number
set numberwidth=4

filetype plugin indent on

highlight LineNr ctermfg=grey

" plugin resources here: https://vimawesome.com
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'bfrg/vim-cpp-modern'

call plug#end()

let g:airline_powerline_fonts=1

" disable golang template upon creating a new file
let g:go_template_autocreate = 0
