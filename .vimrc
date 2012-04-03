
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'git://github.com/gmarik/vundle.git'
Bundle 'git://github.com/kana/vim-operator-user.git'
Bundle 'git://github.com/kana/vim-operator-replace.git'
Bundle 'git://github.com/Shougo/vimshell.git'
Bundle 'git://github.com/Shougo/unite.vim.git'
Bundle 'git://github.com/Shougo/vimfiler.git'
Bundle 'git://github.com/thinca/vim-ref.git'
Bundle 'git://github.com/mattn/perldoc-vim.git'
Bundle 'git://github.com/c9s/perlomni.vim.git'
Bundle 'git://github.com/h1mesuke/vim-alignta.git'
Bundle 'git://github.com/tpope/vim-surround.git'
Bundle 'git://github.com/msanders/snipmate.vim.git'
Bundle 'git://github.com/kana/vim-textobj-user.git'
Bundle 'git://github.com/ujihisa/quickrun.git'
Bundle 'git://github.com/thinca/vim-textobj-comment.git'
Bundle 'git://github.com/thinca/vim-textobj-between.git'
Bundle 'git://github.com/kmnk/vim-unite-svn.git'
Bundle 'git://github.com/vim-scripts/yanktmp.vim.git'
Bundle 'git://github.com/Lokaltog/vim-easymotion.git'
Bundle 'git://github.com/Shougo/vimproc.git'
Bundle 'git://github.com/vimtaku/vim-textobj-sigil.git'
Bundle 'git://github.com/vimtaku/vim-textobj-doublecolon.git'
Bundle 'git://github.com/Shougo/neocomplcache.git'
Bundle 'git://github.com/t9md/vim-textmanip.git'
Bundle 'git://github.com/msanders/snipmate.vim.git'
Bundle 'git://github.com/h1mesuke/unite-outline.git'
Bundle 'git://github.com/tyru/open-browser.vim.git'
Bundle 'git://github.com/vim-scripts/vimwiki.git'
Bundle 'git://github.com/motemen/hatena-vim'
Bundle 'git://gist.github.com/982781.git'


Bundle 'git://github.com/kchmck/vim-coffee-script.git'
Bundle 'git://github.com/ujihisa/shadow.vim.git'



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
    " 一行だけ~/.vimcolorschemeに書いておくことでcolorschemeとして読み込む
    let s:file_path = $HOME. '/.vimcolorscheme'
    if (filereadable(s:file_path))
        for line in readfile(s:file_path)
            execute(line)
        endfor
    endif
endif

""" mappings.

" open new window vertical split when use gf.
nnoremap gf :vsplit<CR>gf


inoremap <C-j> <ESC>
cnoremap <C-j> <ESC>
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
nnoremap <C-p> gt
nnoremap <C-n> gT
nnoremap <tab> gt
nnoremap <S-tab> gT

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

nnoremap : q:a
nnoremap / q/a
nnoremap <silent> <BS> :<C-u>noh<CR>


""" for plugin mappings.


" for operator replace
map R <Plug>(operator-replace)

" ref.vim
let g:ref_perldoc_complete_head = 1

" for surround.vim
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround

" Unite mappings
nnoremap ,ue :Unite file_rec<CR>
nnoremap ,ur :UniteResume<CR>
nnoremap ,uw :UniteWithBufferDir file<CR>
nnoremap ,uc :UniteWithCurrentDir file<CR>
nnoremap ,ul :Unite line<CR>
nnoremap ,uf :Unite file<CR>
nnoremap ,ub :Unite tab buffer<CR>
nnoremap ,uB :Unite bookmark file<CR>
nnoremap ,um :Unite file_mru<CR>
nnoremap ,uo :Unite outline<CR>
nnoremap ,uss :Unite svn/status<CR>

" for unite window height
let g:unite_winheight=10


" for yanktmp
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" quickrun.vim
silent! nmap <unique> ,r <Plug>(quickrun)

" for alingta
vnoremap <silent> => :Align @1 =><CR>
vnoremap <silent> = :Align @1 =<CR>
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

" for hatena-vim
let g:hatena_user = 'vimtaku'

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" for vimwiki
map ,wf <Plug>VimwikiFollowLink
map ,w <Plug>VimwikiIndex
function! Space_Mapping_VimwikiToggleListItem()
    if (&filetype == 'vimwiki')
        map <Space> <Plug>VimwikiToggleListItem<Down>
    else
        noremap <Space> <C-w>
    endif
endfunction

augroup Vimwiki
    autocmd!
    autocmd Filetype,BufEnter vimwiki nnoremap <CR> :<C-u>w<CR>
    autocmd Filetype,BufEnter vimwiki :call Space_Mapping_VimwikiToggleListItem()
augroup END


"" util.

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
    au Filetype c noremap ,z o<ESC>p_iprintf("<ESC>A\n");<ESC>==;
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
    :QuickRun -runmode async:vimproc:20  -exec 'perl ./script/devel/proveit %s'
  endif
endfunction

augroup AutoProveIt
  au!
  au BufWritePost *.t,*.pm :call ProveItWrapper()
augroup END


"" If mode is insert, the status line color will be changed.
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * call s:StatusLine('Enter')
        autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
    if a:mode == 'Enter'
        silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
        silent exec g:hi_insert
    else
        highlight clear StatusLine
        silent exec s:slhlcmd
    endif
endfunction

function! s:GetHighlight(hi)
    redir => hl
    exec 'highlight '.a:hi
    redir END
    let hl = substitute(hl, '[\r\n]', '', 'g')
    let hl = substitute(hl, 'xxx', '', '')
    return hl
endfunction

command! Utf8 :e ++enc=utf8<CR>
command! EucJP :e ++enc=euc-jp<CR>
command! Cp932 :e ++enc=cp932<CR>
command! FencUtf8 :set fenc=utf8<CR>
command! FencEUC :set fenc=euc-jp<CR>
command! FencCp932 :set fenc=cp932<CR>


"" Qfix howm
let QFixHowm_Key      = 'g'
let howm_dir          = $HOME . '/Dropbox/howm'
let QFixHowm_RootDir  = $HOME . '/Dropbox/howm'
let howm_filename     = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding = 'utf8'
let howm_fileformat   = 'unix'
let g:QFixHowm_TitleListCache = 0

"howmディレクトリの切替
nnoremap <silent> g,hh :echo howm_dir<CR>
nnoremap <silent> g,ha :call HowmChEnv('', 'time', '=')<CR>
nnoremap <silent> g,hm :call HowmChEnv('main', 'time', '=')<CR>
nnoremap <silent> g,hw :call HowmChEnv('work', 'time', '=')<CR>
nnoremap <silent> g,hu :call HowmChEnv('ubuntu',   'time', '=')<CR>

