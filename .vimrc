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

" Navigation
nmap <S-Up> :-5<cr>
nmap <S-Down> :+5<cr>
imap <S-Up> <esc>:-5<cr>a
imap <S-Down> <esc>:+5<cr>a


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
nmap P<Up> <C-W><C-K>
nmap P<Down> <C-W><C-J>
nmap P<Left> <C-W><C-H>
nmap P<Right> <C-W><C-L>

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
set smartindent
set smarttab
set mouse=a
set cursorline
set lcs=trail:█
set colorcolumn=100
set tabstop=4
colorscheme tender

" Plugins configurations
let NERDTreeIgnore = ['\.pyc$']
nmap <C-P> :NERDTreeToggle<cr>:silent NERDTreeMirror<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! RemoveTrailingSpaces()
    let pos = getpos(".")
    execute ":%s/\\s\\+$//eg"
    call setpos(".", pos)
endfunction

function! DosToUnix()
    edit ++ff=dos
    setlocal ff=unix
endfunction
nmap D@U :call DosToUnix()<cr>

autocmd BufWritePre * call RemoveTrailingSpaces()
autocmd BufWritePost *.py call Flake8()

" Lightline
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component': {
    \   'readonly': '%{&filetype=="help"?"":&readonly?"☹":""}',
    \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &readonly)',
    \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
    \ },
    \ 'separator': { 'left': "", 'right': "" },
    \ 'subseparator': { 'left': "|", 'right': "|" }
\ }
