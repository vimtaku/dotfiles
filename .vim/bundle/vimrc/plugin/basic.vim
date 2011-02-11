" おまじない
syntax on
filetype plugin on
set nocompatible

" tab関連
set shiftwidth=4
set tabstop=4
set expandtab

" Perl書いているときに#押したら行頭に行っちゃうのを防ぐため
set cinkeys-=0#
set cindent

"特殊文字(SpecialKey)の見える化。listcharsはlcsでも設定可能。
"trailは行末スペース。
set list
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,

" 縦分割をする際、新しいウィンドウを右側に作る
set splitright
" 縦分割した後、カーソル下のタグへジャンプ
nnoremap ,s :vsplit<CR>g]

" gfコマンドもウィンドウ分割して開く
nnoremap gf :vsplit<CR>gf

" バックスペースで消せるように
set backspace=2

" change grep to ack
set grepprg=ack\ -a

" sync unnamed register and *register.
set clipboard=unnamed


"##################################
" FOR SEARCH
"##################################

" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

" 検索系
set hlsearch


"##################################
" FOR ENCODINGS
"##################################

" エンコード関係
" 文字コードの自動認識
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


"##################################
" FOR PERSISTENT UNDO
"##################################
"
" 7.3 veeeeeeeery good undo has come!!
if has('persistent_undo')
  "set undodir=./.vimundo,~/.vimundo
  set undodir=~/.vim/undodir
  set undolevels=10000 "maximum number of changes that can be undone
  set undoreload=10000 "maximum number lines to save for undo on a buffer reload
  set undofile
endif


