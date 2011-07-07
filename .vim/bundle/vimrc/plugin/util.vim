
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

" ¥Õ¥¡¥¤¥ë¥¿¥¤¥×¤Ë¤è¤Ã¤ÆÊÑ¤ï¤ëprint¥Ç¥Ð¥Ã¥°
augroup Dumpers
    :au!
    au Filetype perl noremap ,z :call DataDumper()<CR>
    au Filetype javascript noremap ,z o<ESC>p_iconsole.debug(<ESC>A);<ESC>yypkf(a'<ESC>$F)ha='<ESC>=j
aug END

" ¥Õ¥¡¥¤¥ë¤òÁ°²ó¤È¤¸¤¿»þ¤Î¾ì½ê¤òµ­²±
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


"" ¥Õ¥¡¥¤¥ëºîÀ®»þ¤Ë¡¢»ØÄê¤·¤¿¥Õ¥¡¥¤¥ë¤«¤é¿÷·Á¤¬½ÐÍè¾å¤¬¤ê¤Þ¤¹¡£
"augroup SkeletonAu
"    autocmd!
"    autocmd BufNewFile *.pl 0r $HOME/.vim/templates/skel.pl
"    autocmd BufNewFile *.pm 0r $HOME/.vim/templates/skel.pm
"augroup END


" ËöÈø¤Î¥¹¥Ú¡¼¥¹¤Ê¤É¤ò½üµî(»ÈÍÑ»þÃí°Õ)
function! RTrim()
    let s:cursor = getpos(".")
    %s/\s\+$//e
    call setpos(".", s:cursor)
endfunction

noremap ,trim :call RTrim()<CR>:echo 'trim space!'<CR>

" screen vim¤Ç³«¤¤¤¿¥Õ¥¡¥¤¥ë¤ò¥¹¥Æ¡¼¥¿¥¹¥Ð¡¼¤Î¥¿¥¤¥È¥ë¤Ë
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | silent! exe '!echo -n "k%\\"' | endif


"¹ÔÆ¬¤Î¥¹¥Ú¡¼¥¹¤ÎÏ¢Â³¤ò¥Ï¥¤¥é¥¤¥È¤µ¤»¤ë
"TabÊ¸»ú¤â¶èÊÌ¤µ¤ì¤º¤Ë¥Ï¥¤¥é¥¤¥È¤µ¤ì¤ë¤Î¤Ç¡¢¶èÊÌ¤·¤¿¤¤¤È¤­¤ÏTabÊ¸»ú¤ÎÉ½¼¨¤òÊÌ¤Ë
"ÀßÄê¤¹¤ëÉ¬Í×¤¬¤¢¤ë¡£
function! SOLSpaceHilight()
    syntax match SOLSpace "^\s\+" display containedin=ALL
    highlight SOLSpace term=underline ctermbg=LightGray
endf

"Á´³Ñ¥¹¥Ú¡¼¥¹¤ò¥Ï¥¤¥é¥¤¥È¤µ¤»¤ë¡£
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "¡¡" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
endf

"syntax¤ÎÍ­Ìµ¤ò¥Á¥§¥Ã¥¯¤·¡¢¿·µ¬¥Ð¥Ã¥Õ¥¡¤È¿·µ¬ÆÉ¤ß¹þ¤ß»þ¤Ë¥Ï¥¤¥é¥¤¥È¤µ¤»¤ë
if has("syntax")
"    syntax on
"autocmd BufNew,BufRead * call SOLSpaceHilight()
        augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif


" rename¤¹¤ë
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))


au BufRead,BufNewFile *.t    set filetype=perl
au BufRead,BufNewFile *.tmpl set filetype=html


" ¹Ô¤ÎÃæ±û¤Ë
function! s:JumpMiddle()
    let end = col('$')-1
    let middle = float2nr(ceil(end/2))
    let save_cursor = getpos(".")
    let save_cursor[2] = middle
    call setpos('.', save_cursor)
endfun
nnoremap <silent> M :call <SID>JumpMiddle()<CR>


" Â¸ºß¤·¤Ê¤¤¥Ç¥£¥ì¥¯¥È¥ê²¼¤Î¥Õ¥¡¥¤¥ë¤ò³«¤¤¤Æ¤¤¤ë¾ì¹ç¤Ë¥Ç¥£¥ì¥¯¥È¥ê¤ÎºîÀ®¤ò¹Ô¤¤¤Ä¤ÄÊÝÂ¸¤¹¤ë
command! -nargs=0 Fw call s:WriteAfterMakeDir()
function! s:WriteAfterMakeDir()
    call mkdir(expand('%:h'), 'p')
    write
endfunction


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

