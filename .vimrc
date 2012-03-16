set nocompatible
"
" Mapeamentos
"

" Tab como esc
nmap <tab> <esc>
imap <tab> <esc>
vmap <tab> <esc>

" Tabs
nmap tn :tabnew<cr>
nmap tm :tabmove<space>
nmap t[ :tabprev<cr>
nmap t] :tabnext<cr>

" Buffers
nmap bl :ls<cr>
nmap be bl:b<space>
nmap ball :ball<cr>

" Remover o arquivo do buffer
nmap bd :bd<cr>

" Salvar
imap <leader>s<cr> <esc>:w<cr>a

"
" Edicao de arquivos
"
set et
let python_highlight_all = 1
set sw=4
set sts=4
set encoding=utf8
syntax on
set number
set incsearch
set hlsearch
set mouse=v
set smartindent

" Viadagem
set cursorline

" Pluginhos
autocmd vimenter * if !argc() | NERDTree | endif

" Remover espacos
autocmd BufWritePre * :%s/\s\+$//eg

" Valida o arquivo pep8
autocmd BufWritePost *.py call Flake8()
