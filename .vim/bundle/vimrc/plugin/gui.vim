" 強化されたタブメニュー(GUI)
set wildmenu

" ステータスライン
set laststatus=2
set statusline=%<%f\%m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L

" 画面のスクロール幅10行でスクロール開始
set scrolloff=10

" マウスモード有効
set mouse=a

" screen対応
set ttymouse=xterm2

" カラースキーマ
if (has('win32'))
    colorscheme slate
elseif (has('mac'))
    colorscheme koehler
else
    colorscheme koehler
endif

