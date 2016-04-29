set nocompatible

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
"
" Mapeamentos
"

" Thou shall not tab!!
nmap <tab> <esc>
imap <tab> <esc>
vmap <tab> <esc>

" Tabs
nmap tn :tabnew<cr>
nmap tm :tabmove<space>
nmap t[ :tabprev<cr>
nmap t] :tabnext<cr>
nmap <C-PageUp> :tabprev<cr>
nmap <C-PageDown> :tabnext<cr>

" Buffers
nmap bl :ls<cr>
nmap be bl:b<space>
nmap ball :ball<cr>

nmap bd :bd<cr>


" Pane navigation
nmap p<Up> <C-W><C-K>
nmap p<Down> <C-W><C-J>
nmap p<Left> <C-W><C-H>
nmap p<Right> <C-W><C-L>

" Save short cut
imap <leader>s<cr> <esc>:w<cr>a

" Python standards
set et
let python_highlight_all = 1
set sw=4
set sts=4
set encoding=utf8

" Stuff I like
syntax on
set number
set incsearch
set hlsearch
set mouse=v
set smartindent
set cursorline
set lcs=trail:█
set colorcolumn=100
colorscheme default

" Plugins configurations
let NERDTreeIgnore = ['\.pyc$']
nmap <C-P> :NERDTreeToggle<cr>

autocmd BufWritePre * :%s/\s\+$//eg
autocmd BufWritePost *.py call Flake8()



