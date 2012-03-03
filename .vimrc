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

" Remover o arquivo do buffer
nmap bd :bd<cr>
" Eu costumo apertar db ao inves de bd, mas nesse caso eu vou ter que apertar enter pra confirmar a cagada
nmap db :bd

" Salvar
imap <leader>s<cr> <esc>:w<cr>a

