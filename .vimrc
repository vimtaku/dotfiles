" vim:set fen fdm=marker:
" Basic {{{1
set nocompatible
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

filetype plugin indent on

call neobundle#rc(expand('~/.vim/bundle/'))


" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

let g:skk_control_j_key = ""
let g:skk_large_jisyo = "$HOME/local/dict/SKK-JISYO.L"

""" let Vundle manage Vundle {{{2

NeoBundle 'git://github.com/kchmck/vim-coffee-script.git'
NeoBundle 'git://github.com/digitaltoad/vim-jade.git'
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Lokaltog/vim-easymotion.git'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimproc.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'adie/BlockDiff.git'
NeoBundle 'c9s/perlomni.vim.git'
NeoBundle 'gmarik/vundle.git'
NeoBundle 'h1mesuke/unite-outline.git'
NeoBundle 'h1mesuke/vim-alignta.git'
NeoBundle 'kana/vim-operator-replace.git'
NeoBundle 'kana/vim-operator-user.git'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-lastpat'
NeoBundle 'kana/vim-textobj-user.git'
NeoBundle 'kmnk/vim-unite-svn.git'
NeoBundle 'kmnk/vim-unite-giti.git'
NeoBundle 'koron/chalice'
NeoBundle 'mattn/perldoc-vim.git'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'motemen/hatena-vim'
NeoBundle 'msanders/snipmate.vim.git'
NeoBundle 'msanders/snipmate.vim.git'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 't9md/vim-textmanip.git'
NeoBundle 'thinca/vim-poslist'
NeoBundle 'thinca/vim-ref.git'
NeoBundle 'thinca/vim-textobj-between.git'
NeoBundle 'thinca/vim-textobj-comment.git'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'tpope/vim-repeat.git'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'tyru/open-browser.vim.git'
NeoBundle 'ujihisa/quickrun.git'
NeoBundle 'vim-scripts/vimwiki.git'
NeoBundle 'vim-scripts/yanktmp.vim.git'
NeoBundle 'vimtaku/vim-textobj-doublecolon.git'
NeoBundle 'vimtaku/vim-textobj-sigil.git'
NeoBundle 'vimtaku/vim-textobj-keyvalue.git'
NeoBundle 'vimtaku/vim-mlh.git'
NeoBundle 'vimtaku/textobj-wiw.git'
NeoBundle 'vimtaku/hl_matchit.vim.git'
NeoBundle 'vimtaku/mixi-graph-api.git'
NeoBundle 'ynkdir/vim-funlib'
NeoBundle 'choplin/unite-vim_hacks'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-font'
NeoBundle 'ujihisa/ref-hoogle.git'
NeoBundle 't9md/vim-phrase'
NeoBundle 'tomtom/tcomment_vim.git'
NeoBundle 'vim-scripts/JavaScript-Indent.git'
NeoBundle 'mattn/learn-vimscript.git'
NeoBundle 'kana/vim-submode.git'
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'tyru/skk.vim.git'
NeoBundle 'altercation/vim-colors-solarized.git'
NeoBundle 'ujihisa/shadow.vim'
NeoBundle 'git://github.com/kchmck/vim-coffee-script.git'
NeoBundle 'git://github.com/wavded/vim-stylus.git'
NeoBundle "git://github.com/vim-scripts/VimRepress"
NeoBundle 'git://github.com/fuenor/qfixhowm'
NeoBundle 'vimtaku/vim-operator-ppd'
NeoBundle "osyo-manga/unite-qfixhowm"


function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
call <SID>vimrc_local($HOME)

"Load settings for each location.
augroup vimrc-local
  autocmd!
  autocmd BufRead,BufNewFile * call s:vimrc_local($HOME)
augroup END



" basic config. {{{2
syntax on
set nocompatible

" tab indent
set shiftwidth=4
set tabstop=4
set expandtab

set cinkeys-=0#
set cindent
set smartindent

" when use . command, repeat yank.
set cpoptions+=y

" visualize to SpecialKeys.
set list
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,

" when create new window split vertically, create window right side
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


set autoread
set noswapfile


" create swp data to only tmp directory
"set directory&
"set directory-=.

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
set statusline=%<%f\%m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%4v\ %l/%L
set showcmd

set scrolloff=10

" Enable mouse support.
set mouse=a
" For screen.
if &term =~ "^screen"
    augroup MyAutoCmd
        autocmd!
        autocmd VimLeave * :set mouse=
     augroup END
    " screenでマウスを使用するとフリーズするのでその対策
    set ttymouse=xterm2
endif
if has('gui_running')
    " Show popup menu if right click.
    set mousemodel=popup
    " Don't focus the window when the mouse pointer is moved.
    set nomousefocus
    " Hide mouse pointer on insert mode.
    set mousehide
endif


set isfname-=:
set isfname-=-

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

" end of basic conf. }}}2

" mappings. {{{2

" open new window vertical split when use gf.
nnoremap gf :vsplit<CR>gf
nnoremap gF <C-W>gf

inoremap <C-j> <ESC>
cnoremap <C-j> <ESC>

inoremap <C-l> <C-x><C-l>
inoremap <C-y> <C-w>
cnoremap <C-y> <C-w>

noremap <C-k> <C-u>
noremap <C-j> <C-d>

nnoremap j gj
nnoremap k gk

noremap <Space> <C-w>

" move tab focus
nnoremap <C-p> gt
nnoremap <C-n> gT
nnoremap <tab> gt
nnoremap <S-tab> gT

" for masui special.
noremap g<CR> g;
nnoremap <CR> :<C-u>w<CR>

nnoremap q :<C-u>q<CR>
nnoremap Q q

noremap ,ev :e ~/.vimrc<CR>
noremap ,re :source ~/.vimrc<CR>:echo 'reload .vimrc!!'<CR>
noremap ,v :r! cat -<CR>


nnoremap : q:a
nnoremap / q/a
nnoremap <silent> <BS> :<C-u>noh<CR>

" reselect paste resion
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" paste yanked string vertically
vnoremap <C-p> I<C-r>"<ESC><ESC>

nnoremap <C-h> :noh<CR>

"}}}2


""" for plugin mappings.{{{2

" for operator replace
map R <Plug>(operator-replace)


" ref.vim
let g:ref_perldoc_complete_head = 1

" for surround.vim
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround

" unite prefix key
nnoremap [unite] <Nop>

nmap ,u [unite]

" Unite mappings
nnoremap [unite]e  :<C-u>Unite file_rec file/new<CR>
nnoremap [unite]w  :<C-u>UniteWithBufferDir file file/new file_rec<CR>
nnoremap [unite]c  :<C-u>UniteWithCurrentDir file file/new file_rec<CR>
nnoremap [unite]f  :<C-u>Unite file file/new<CR>
nnoremap [unite]b  :<C-u>Unite tab buffer<CR>
nnoremap [unite]B  :<C-u>Unite bookmark file file/new<CR>
nnoremap [unite]m  :<C-u>Unite file_mru<CR>
nnoremap [unite]o  :<C-u>Unite outline<CR>
nnoremap [unite]ss :<C-u>Unite svn/status<CR>
nnoremap [unite]vh :<C-u>Unite vim_hacks<CR>
nnoremap [unite]gs :<C-u>Unite giti/status<CR>
nnoremap [unite]gb :<C-u>Unite giti/branch<CR>
nnoremap [unite]md :<C-u>Unite directory_mru<CR>

nnoremap <expr> [unite]% ':<C-u>Unite file file/new -input=' . expand('%:p') . '<CR>'

nnoremap [unite]l  :<C-u>Unite qfixhowm<CR>



" for unite window height
let g:unite_winheight=10
let g:unite_source_history_yank_enable=1
let g:unite_update_time=200

" for neocom
let g:neocomplcache_enable_at_startup = 1

" for yanktmp
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" quickrun.vim
silent! nmap ,r <Plug>(quickrun)
silent! vnoremap ,r :QuickRun perl -exec '%c -Ilib %s'<CR>
silent! vnoremap ,gr gv:QuickRun perl -exec '%c -Ilib %s'<CR>

" for alingta
vnoremap <silent> => :Align @1 =><CR>
vnoremap <silent> = :Align @1 =<CR>
vnoremap <silent> == =


" for vimshell
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
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

let g:vimshell_interactive_update_time = 300

" for hatena-vim
let g:hatena_user = 'vimtaku'


" for VimRepress
let VIMPRESS = [{'username':'vimtaku',
                \'blog_url':'http://qolwu.com/'
                \}]


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


" for vim mlh
imap <C-b> <Plug>(vim_mlh-i_retransliterate)<C-n>
nmap <C-b> <Plug>(vim_mlh-retransliterate)<C-n>


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
    au Filetype javascript noremap ,z o<ESC>p_iconsole.log(<ESC>A);<ESC>yypkf(a'<ESC>$F)ha='<ESC>=j
    au Filetype coffee noremap ,z o<ESC>p_iconsole.log<Space><ESC>A<ESC>yypkf<Space>a'<ESC>A='<ESC>=j
    au Filetype c noremap ,z o<ESC>p_iprintf("<ESC>A\n");<ESC>==;
    au Filetype php noremap ,z o<ESC>p_ivar_dump("<ESC>A=".<ESC>pa);<ESC>
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

function! s:ToggleProveIt()
    if (g:auto_prove_it_enable == 0)
      let g:auto_prove_it_enable = 1
    else
      let g:auto_prove_it_enable = 0
    endif
endfunction

command! ToggleProveIt :call s:ToggleProveIt()

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

command! DeleteAlert :g/alert(/d
command! DeleteConsole :g/console.\(log\|debug\)/d

"" Qfix howm
let QFixHowm_Key      = 'g'
let howm_dir          = $HOME . '/Dropbox/howm'
let QFixHowm_RootDir  = $HOME . '/Dropbox/howm'
let howm_filename     = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding = 'utf8'
let howm_fileformat   = 'unix'
let g:QFixHowm_TitleListCache = 0

nmap g, [howm]
"howmディレクトリの切替
nnoremap <silent> [howm]hh :echo howm_dir<CR>
nnoremap <silent> [howm]ha :call HowmChEnv('', 'time', '=')<CR>
nnoremap <silent> [howm]hm :call HowmChEnv('main', 'time', '=')<CR>
nnoremap <silent> [howm]hw :call HowmChEnv('work', 'time', '=')<CR>
nnoremap <silent> [howm]hu :call HowmChEnv('ubuntu',   'time', '=')<CR>

" new buffer
command! Tempfile :e `=tempname()`

" read matchit
runtime macros/matchit.vim
let b:match_words = &matchpairs . ',<TMPL_IF:</TMPL_IF>,<TMPL_LOOP:</TMPL_LOOP>'


" " gui indent guides
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_guide_size = 1
" let g:indent_guides_color_change_percent = 30
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=8
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=8

highlight Normal ctermfg=White

"" set tab color
hi TabLineSel ctermbg=DarkMagenta

" url encode by alice.vim
function! s:URLEncode()
    let l:line = getline('.')
    let l:encoded = AL_urlencode(l:line)
    call setline('.', l:encoded)
endfunction

function! s:URLDecode()
    let l:line = getline('.')
    let l:decoded = AL_urldecode(l:line)
    call setline('.', l:decoded)
endfunction
command! -nargs=0 -range URLEncode :<line1>,<line2>call <SID>URLEncode()
command! -nargs=0 -range URLDecode :<line1>,<line2>call <SID>URLDecode()


" Randome, MD5, Sha1, Sha256 functions
function! Random(a, b)
    return random#randint(a:a, a:b)
endfunction

function! MD5(data)
    return hashlib#md5(a:data)
endfunction

function! Sha1(data)
    return hashlib#sha1(a:data)
endfunction

function! Sha256(data)
    return hashlib#sha256(a:data)
endfunction


"}}}2 endof plugin mappings and so on.

hi LineNr term=underline ctermfg=White ctermbg=Magenta


let g:tcommentMapLeaderOp1='go'
let g:tcommentMapLeaderOp2='gO'

function! OperatorYankClipboard(motion_wiseness)
  let visual_commnad =
  \ operator#user#visual_command_from_wise_name(a:motion_wiseness)
  execute 'normal!' '`['.visual_commnad.'`]"+y'
endfunction

call operator#user#define('yank-clipboard', 'OperatorYankClipboard')
map gy  <Plug>(operator-yank-clipboard)


function! s:JavascriptLambda()
    setlocal conceallevel=2
    syntax keyword javaScriptLambda function conceal cchar=\
    highlight clear Conceal
    highlight link Conceal Identifier
    highlight link javaScriptLambda Identifier
endf

augroup JavascriptLambda
  au!
  au BufRead,BufNewFile *.js :call s:JavascriptLambda()
augroup END
" vim --cmd "profile start result.txt" --cmd "profile file */plugin/*.vim" -c quit
function! s:InspectVimStartup()
    let s:list = []
    global/^SCRIPT/
    \ call add(s:list, printf("%s\t%s",
    \                         matchstr(getline(line('.')+2), '\d\+\.\d\+'),
    \                         matchstr(getline('.'), 'SCRIPT\s*\zs.*$')))
    new
    put =reverse(sort(s:list))
    1 delete _
endfunction
command! -nargs=0 -range InspectVimStartup :call <SID>InspectVimStartup()


command! StartGuard :call vimproc#system('perl $HOME/guard_start.pl')
command! RestartGuard :call vimproc#system('pkill guard && perl $HOME/guard_start.pl')

nnoremap [quickrun_mocha] :execute("QuickRun mocha -runmode async:vimproc:40 -exec '%c " . substitute( substitute( expand('%:p'), 'coffee', 'Resources', ''), 'coffee', 'js', '') . "'")<CR>


augroup QuickRunCoffeeAndMocha
  autocmd!
  autocmd Filetype coffee nmap ,r [quickrun_mocha]
augroup END

augroup StylusAutoCompile
  au!
  au BufWritePost *.styl :QuickRun -runmode async:vimproc:40 -exec "stylus %s" -output _
augroup END


"" Create help contents command by thinca http://d.hatena.ne.jp/thinca/20110903/1314982646
command! -buffer -bar GenerateContents call s:generate_contents()
function! s:generate_contents()
  let cursor = getpos('.')

  let plug_name = expand('%:t:r')
  let ja = expand('%:e') ==? 'jax'
  1

  if search(plug_name . '-contents\*$', 'W')
    silent .+1;/^=\{78}$/-1 delete _
    .-1
    put =''
  else
    /^License:/+1
    let header = printf('%s%s*%s-contents*', (ja ? "目次\t" : 'CONTENTS'),
    \            repeat("\t", 5), plug_name)
    silent put =['', repeat('=', 78), header]
    .+1
  endif

  let contents_pos = getpos('.')

  let lines = []
  while search('^\([=-]\)\1\{77}$', 'W')
    let head = getline('.') =~ '=' ? '' : '  '
    .+1
    let caption = matchlist(getline('.'), '^\([^\t]*\)\t\+\*\(\S*\)\*$')
    if !empty(caption)
      let [title, tag] = caption[1 : 2]
      call add(lines, printf("%s%s\t%s|%s|", head, title, head, tag))
    endif
  endwhile

  call setpos('.', contents_pos)

  silent put =lines + ['', '']
  call setpos('.', contents_pos)
  let len = len(lines)
  setlocal expandtab tabstop=32
  execute '.,.+' . len . 'retab'
  setlocal noexpandtab tabstop=8
  execute '.,.+' . len . 'retab!'

  call setpos('.', cursor)
endfunction



function! SetColumnWidthLimit()
  setlocal textwidth=78
  if exists('+colorcolumn')
    setlocal colorcolumn=+1
  endif
endfun

au Filetype perl,javascript,vim call SetColumnWidthLimit()




nnoremap [quickrun_phpunit] :execute("QuickRun phpunit -runmode async:vimproc:40 -exec '%c %%'")<CR>
augroup QuickRunPhpUnit
  autocmd!
  autocmd Filetype php nmap ,t [quickrun_phpunit]
augroup END

"!phpunit Tests_Util_Date %


" for operator ppd
map zp <Plug>(operator-ppd)

" function! GetOccurances(text, search)
"     let i = 0
"     let c = 0
"     while (1)
"         let idx = match(a:text, a:search, i)
"         if idx < 0
"            break
"         endif
"         let i = idx + 1
"         let c = c+1
"     endwhile
"     return c
" endfun
" 
" function! ToList(text, times)
"     let i = 0
"     let list = []
"     while i < a:times
"        call add(list, a:text)
"        let i = i+1
"     endwhile
"     return list
" endfun
" 
" function! Times(text, times)
"     return join(ToList(a:text, a:times), '')
" endfunction
" 
" function GetTemplated(text)
"     let s:setting = {
"     \ 'perl' : {
"     \   'template': join(
"     \    [ "use Data::Dumper;\n"
"     \    . "warn 'XXX DEBUG [". bufname('')."] L". getpos(".")[1] . " %s is below.';" . "\n"
"     \    . 'warn Dumper \\%s ;' . "\n"
"     \    ], ""),
"     \ }
"     \}
"     let template = s:setting['perl']['template']
"     let placeholder_count = GetOccurances(template, '%s ')
"     let printf_args = Times('a:text,', placeholder_count)[0:-2]
"     execute "let ret = printf(template, " . printf_args . ")"
"     return ret
" endfunction
" 
" 
" function! OperatorVoidChange(motion_wise)
"     let v = operator#user#visual_command_from_wise_name(a:motion_wise)
"     let tmp_reg = @"
"     try
"         execute 'normal!' '`[' . v . '`]""y'
"         let text = @"
"         let templated_text = GetTemplated(text)
"         put =[expand(templated_text)]
"     finally
"         let @" = tmp_reg
"         if has('x11')
"             let @* = tmp_reg
"         endif
"     endtry
" endfunction
" call operator#user#define('void-change', 'OperatorVoidChange')
" 
" map E <Plug>(operator-void-change)


"" for hl_matchit
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_speed_level = 1
let g:hl_matchit_allow_ft = 'html,vim,ruby'




