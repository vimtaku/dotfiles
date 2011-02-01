
"###################################
"## COMMAND MAPPINGS
"###################################

inoremap <C-j> <ESC>
inoremap <C-l> <C-x><C-l>
inoremap <C-y> <C-w>

noremap <C-k> <C-u>
noremap <C-j> <C-d>

" 物理行移動
nnoremap j gj
nnoremap k gk

noremap <Space> <C-w>
noremap dw de


"##################################
" SHORTCUT MAPPINGS
"##################################

noremap ,ev :e ~/.vimrc<CR>
noremap ,e :source ~/.vimrc<CR>:echo 'read vimrc!'<CR>
noremap ,re :source ~/.vimrc<CR>:echo 'reload .vimrc!!'<CR>
noremap ,v :r! cat -<CR>

