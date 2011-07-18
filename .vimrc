set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle.git'
Bundle 'kana/vim-operator-user.git'
Bundle 'kana/vim-operator-replace.git'
Bundle 'Shougo/vimshell.git'
Bundle 'Shougo/unite.vim.git'
Bundle 'thinca/vim-ref.git'
Bundle 'mattn/perldoc-vim.git'
Bundle 'c9s/perlomni.vim.git'
Bundle 'h1mesuke/vim-alignta.git'
Bundle 'tpope/vim-surround.git'
Bundle 'msanders/snipmate.vim.git'
Bundle 'kana/vim-textobj-user.git'
Bundle 'ujihisa/quickrun.git'
Bundle 'thinca/vim-textobj-comment.git'
Bundle 'thinca/vim-textobj-between.git'
Bundle 'kmnk/vim-unite-svn.git'
Bundle 'vim-scripts/yanktmp.vim.git'
Bundle 'Lokaltog/vim-easymotion.git'
Bundle 'Shougo/vimproc.git'
Bundle 'vimtaku/vim-textobj-sigil.git'
Bundle 'vimtaku/vim-textobj-doublecolon.git'
Bundle 'Shougo/neocomplcache.git'
Bundle 't9md/vim-textmanip.git'

filetype plugin indent on

call pathogen#runtime_append_all_bundles()

let g:neocomplcache_enable_at_startup = 1


"" basic config.
syntax on
set nocompatible

" tab indent
set shiftwidth=4
set tabstop=4
set expandtab

set cinkeys-=0#
set cindent

" when use . command, repeat yank.
set cpoptions+=y

" visualize to SpecialKeys.
set list
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,

" 縦分割をする際、新しいウィンドウを右側に作る
set splitright

set backspace=2

" change grep to ack
set grepprg=ack\ -a

" sync unnamed register and *register.
set clipboard=unnamed

"" searching.
set ignorecase
set smartcase
set hlsearch
set incsearch


"" encodings.
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif


" persistent undo
if has('persistent_undo')
  "set undodir=./.vimundo,~/.vimundo
  set undodir=~/.vim/undodir
  set undolevels=10000 "maximum number of changes that can be undone
  set undoreload=10000 "maximum number lines to save for undo on a buffer reload
  set undofile
endif


"" gui settings
set wildmenu

" status line.
set laststatus=2
set statusline=%<%f\%m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L

set scrolloff=10

set mouse=a

set ttymouse=xterm2


"" color scheme.
if (has('win32'))
    colorscheme slate
elseif (has('mac'))
    colorscheme koehler
else
    colorscheme slate
endif





""" mappings.

" open new window vertical split when use gf.
nnoremap gf :vsplit<CR>gf


inoremap <C-j> <ESC>
inoremap <C-l> <C-x><C-l>
inoremap <C-y> <C-w>
cnoremap <C-y> <C-w>

noremap <C-k> <C-u>
noremap <C-j> <C-d>

nnoremap j gj
nnoremap k gk

"noremap dw de
noremap <Space> <C-w>

" move tab focus
noremap <Tab> gt
noremap <S-Tab> gT

" for masui special.
noremap g<CR> g;
nnoremap <CR> :<C-u>w<CR>

noremap ( /(<CR>:call histdel('/', -1)<CR>:noh<CR>
noremap ) /)<CR>:call histdel('/', -1)<CR>:noh<CR>
noremap { /{<CR>:call histdel('/', -1)<CR>:noh<CR>
noremap } /}<CR>:call histdel('/', -1)<CR>:noh<CR>


noremap ,ev :e ~/.vimrc<CR>
noremap ,re :source ~/.vimrc<CR>:echo 'reload .vimrc!!'<CR>
noremap ,v :r! cat -<CR>



""" for plugin mappings.


" for operator replace
map R <Plug>(operator-replace)

" ref.vim
let g:ref_perldoc_complete_head = 1

" for surround.vim
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround

" Unite mappings
noremap ,ue :Unite -no-quit file_rec<CR>
noremap ,ur :UniteResume<CR>
noremap ,uw :UniteWithBufferDir -no-quit file<CR>
noremap ,uf :Unite -no-quit file<CR>
noremap ,ub :Unite -no-quit buffer<CR>
noremap ,uB :Unite -no-quit bookmark file<CR>
noremap ,um :Unite -no-quit file_mru<CR>
noremap ,uss :Unite -no-quit svn/status<CR>

" for unite window height
let g:unite_winheight=10
let g:unite_enable_start_insert=1


" for yanktmp
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" quickrun.vim
silent! nmap <unique> ,r <Plug>(quickrun)

" for alingta
vnoremap <silent> => :Align=><CR>
vnoremap <silent> = :Align=<CR>
vnoremap <silent> == =


" for vimshell
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
let g:vimshell_enable_smart_case = 1

if has('win32') || has('win64') 
  " Display user name on Windows.
  let g:vimshell_prompt = $USERNAME."% "
else
  " Display user name on Linux.
  let g:vimshell_prompt = $USER."% "

  call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
  call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
  let g:vimshell_execute_file_list['zip'] = 'zipinfo'
  call vimshell#set_execute_file('tgz,gz', 'gzcat')
  call vimshell#set_execute_file('tbz,bz2', 'bzcat')
endif

autocmd FileType vimshell
\ call vimshell#altercmd#define('g', 'git')
\| call vimshell#altercmd#define('i', 'iexe')
\| call vimshell#altercmd#define('l', 'll')
\| call vimshell#altercmd#define('ll', 'ls -l')
\| call vimshell#hook#set('chpwd', ['g:my_chpwd'])
\| call vimshell#hook#set('emptycmd', ['g:my_emptycmd'])
\| call vimshell#hook#set('preprompt', ['g:my_preprompt'])
\| call vimshell#hook#set('preexec', ['g:my_preexec'])

function! g:my_chpwd(args, context)
  call vimshell#execute('echo "chpwd"')
endfunction
function! g:my_emptycmd(cmdline, context)
  call vimshell#execute('echo "emptycmd"')
  return a:cmdline
endfunction
function! g:my_preprompt(args, context)
  call vimshell#execute('echo "preprompt"')
endfunction
function! g:my_preexec(cmdline, context)
  call vimshell#execute('echo "preexec"')

  let l:args = vimproc#parser#split_args(a:cmdline)
  if len(l:args) > 0 && l:args[0] ==# 'diff'
call vimshell#set_syntax('diff')
  endif

  return a:cmdline
endfunction

" vimshell mappings
nnoremap ,s :VimShell<CR>


" 選択したテキストの移動
vmap <C-j> <Plug>(Textmanip.move_selection_down)
vmap <C-l> <Plug>(Textmanip.move_selection_right)
vmap <C-k> <Plug>(Textmanip.move_selection_up)
vmap <C-h> <Plug>(Textmanip.move_selection_left)

" 行の複製
vmap <C-d> <Plug>(Textmanip.duplicate_selection_v)
nmap <C-d> <Plug>(Textmanip.duplicate_selection_n)


"" utilities.

function! DataDumper()
    let l:use_str = 'use Data::Dumper;'
    let l:yanked = getreg('""')
    let l:currow = getpos(".")[1]
    let l:escaped_yanked = escape(escape(escape(l:yanked, '$'), '@'), '%')
    let l:str = 'warn "{XXX DEBUG ['.bufname('').'] L'.l:currow. '} '. l:escaped_yanked .' is below.";'
    call append(l:currow, l:use_str)
    call append(l:currow+1, l:str)
    call append(l:currow+2, 'warn Dumper '.l:yanked.';')
    let l:pos = getpos(".")
    let l:list = l:pos[1:3]
    let l:list[0] = l:list[0] + 1
    call cursor(l:list)
endf

augroup Dumpers
    :au!
    au Filetype perl noremap ,z :call DataDumper()<CR>
    au Filetype javascript noremap ,z o<ESC>p_iconsole.debug(<ESC>A);<ESC>yypkf(a'<ESC>$F)ha='<ESC>=j
aug END

if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

function! RTrim()
    let s:cursor = getpos(".")
    %s/\s\+$//e
    call setpos(".", s:cursor)
endfunction

noremap ,trim :call RTrim()<CR>:echo 'trim space!'<CR>

" for screen settings.
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | silent! exe '!echo -n "k%\\"' | endif

function! SOLSpaceHilight()
    syntax match SOLSpace "^\s\+" display containedin=ALL
    highlight SOLSpace term=underline ctermbg=LightGray
endf

" multibyte space highlighting.
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
endf
"syntaxの有無をチェックし、新規バッファと新規読み込み時にハイライトさせる
if has("syntax")
        augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif

au BufRead,BufNewFile *.t    set filetype=perl
au BufRead,BufNewFile *.tmpl set filetype=html

function! s:JumpMiddle()
    let end = col('$')-1
    let middle = float2nr(ceil(end/2))
    let save_cursor = getpos(".")
    let save_cursor[2] = middle
    call setpos('.', save_cursor)
endfun
nnoremap <silent> M :call <SID>JumpMiddle()<CR>


"" for prove it automatically.
let g:auto_prove_it_enable = 0

function! s:toggle_prove_it()
    if (g:auto_prove_it_enable == 0)
      let g:auto_prove_it_enable = 1
    else
      let g:auto_prove_it_enable = 0
    endif
endfunction

command! ToggleProveIt :call s:toggle_prove_it()

function! ProveItWrapper()
  if (g:auto_prove_it_enable == 1)
    " fixme
    :QuickRun -runmode async:vimproc:20 -exec 'perl %s'
  endif
endfunction

augroup AutoProveIt
  au!
  au BufWritePost *.t,*.pm,*.pl :call ProveItWrapper()
augroup END

