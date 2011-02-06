
" for operator replace
map R <Plug>(operator-replace)

" ref.vim
let g:ref_perldoc_complete_head = 1

" for surround.vim
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround

" for NERDTree
noremap ,n :NERDTreeToggle<CR>

" Unite mappings
noremap ,ue :Unite -no-quit file_rec<CR>
noremap ,ur :UniteResume<CR>
noremap ,uw :UniteWithBufferDir -no-quit file<CR>
noremap ,uf :Unite -no-quit file<CR>
noremap ,ub :Unite -no-quit buffer<CR>
noremap ,um :Unite -no-quit file_mru<CR>

" for unite window height
let g:unite_winheight=10


" for yanktmp
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" quickrun.vim
silent! nmap <unique> ,r <Plug>(quickrun)
