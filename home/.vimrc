
set nocompatible
set encoding=utf8
scriptencoding utf8
set fileencodings=utf8,cp932,iso-2022-jp,euc-jp,default,latin


let s:neobundle_dir = expand('~/.vim/.bundle')
if has('vim_starting') "{{{
  " Load neobundle.
  if isdirectory('neobundle.vim')
    set runtimepath^=neobundle.vim
  elseif finddir('neobundle.vim', '.;') != ''
    execute 'set runtimepath^=' . finddir('neobundle.vim', '.;')
  elseif &runtimepath !~ '/neobundle.vim'
    if !isdirectory(s:neobundle_dir.'/neobundle.vim')
      execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
            \ (exists('$http_proxy') ? 'https' : 'git'))
            \ s:neobundle_dir.'/neobundle.vim'
    endif

    execute 'set runtimepath^=' . s:neobundle_dir.'/neobundle.vim'
  endif
endif
"}}}

let g:neobundle#install_process_timeout = 2000
call neobundle#rc(s:neobundle_dir)

"" NeoBundleLine {{{

NeoBundle 'Shougo/neobundle.vim'
NeoBundleLazy 'Shougo/vimproc'
if has('lua')
NeoBundle 'Shougo/neocomplete.vim'
else
NeoBundleLazy 'Shougo/neocomplcache', {'autoload': {'insert': 1}}
end

NeoBundle 'Shougo/neomru.vim'
NeoBundleLazy 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundleLazy 'Shougo/vimshell.vim', { 'depends' : [ 'vimproc' ] }
NeoBundleLazy 'supermomonga/vimshell-pure.vim', { 'depends' : [ 'Shougo/vimshell.vim' ] }
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'adie/BlockDiff'
NeoBundleLazy 'h1mesuke/vim-alignta'
NeoBundleLazy 'kana/vim-operator-user'
NeoBundleLazy 'kana/vim-operator-replace'
NeoBundleLazy 'vimtaku/vim-operator-mdurl'

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'thinca/vim-textobj-between'
NeoBundle 'mattn/vim-textobj-url'

NeoBundleLazy 'tpope/vim-repeat'
NeoBundleLazy 'tpope/vim-surround'
NeoBundle 'kmnk/vim-unite-giti.git'
NeoBundle 'mattn/webapi-vim.git'
NeoBundle 'vim-scripts/yanktmp.vim'
NeoBundle 'vimtaku/vim-textobj-doublecolon.git'
NeoBundle 'vimtaku/vim-textobj-sigil.git'
NeoBundle 'vimtaku/vim-textobj-keyvalue.git'
NeoBundle 'tyru/skk.vim'
NeoBundleLazy 'vimtaku/vim-mlh'
NeoBundle 'vimtaku/textobj-wiw.git'
NeoBundle 'vimtaku/hl_matchit.vim'
NeoBundleLazy 'ujihisa/quickrun'
NeoBundleLazy 'vim-scripts/JavaScript-Indent'
NeoBundle 'fuenor/qfixhowm'

NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'basyura/unite-rails'
NeoBundleLazy 'tpope/vim-endwise'
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'

NeoBundle 'gist:hail2u/747628', {
       \ 'name': 'markdown-cheat-sheet.jax',
       \ 'script_type': 'doc'}

NeoBundle 'mattn/httpstatus-vim'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

NeoBundleLazy 'thoughtbot/vim-rspec', {
                \ 'depends'  : 'tpope/vim-dispatch',
                \ 'autoload' : { 'filetypes' : ['ruby'] }
              \ }


"" }}}

if neobundle#tap('vimproc') " {{{
  call neobundle#config({'build':
      \ {
      \ 'windows': 'make -f make_mingw32.mak',
      \ 'cygwin': 'make -f make_cygwin.mak',
      \ 'mac': 'make -f make_mac.mak',
      \ 'unix': 'make -f make_unix.mak'
      \ }})
endif "" }}}

if neobundle#tap('unite.vim') " {{{
    call neobundle#config({'autoload': {'commands':['Unite', "UniteWithBufferDir", "UniteWithCurrentDir"]}})

    function! neobundle#tapped.hooks.on_source(bundle)
        let g:unite_winheight=10
        let g:unite_source_history_yank_enable=1
        let g:unite_update_time=200
    endf

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
    nnoremap [unite]md :<C-u>Unite directory_mru<CR>
    nnoremap [unite]l  :<C-u>Unite qfixhowm<CR>
    nnoremap <expr> [unite]% ':<C-u>Unite file file/new -input=' . expand('%:p') . '<CR>'
    nnoremap [unite]gs :<C-u>Unite giti/status<CR>
    nnoremap [unite]gb :<C-u>Unite giti/branch<CR>

    call unite#custom#profile('action', 'context', {'start_insert' : 1})
endif " }}}


if neobundle#tap('neocomplete.vim') " {{{
   call neobundle#config({'autoload': {
     \ 'insert':1,
     \ 'commands' : 'NeoCompleteBufferMakeCache',
     \ }})
   let g:neocomplete#enable_at_startup = 1
   if exists('g:loaded_neocomplete')

       " Disable AutoComplPop.
       let g:acp_enableAtStartup = 0
       " Use smartcase.
       let g:neocomplete#enable_smart_case = 1
       " Set minimum syntax keyword length.
       let g:neocomplete#sources#syntax#min_keyword_length = 3
       let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

       " Define dictionary.
       let g:neocomplete#sources#dictionary#dictionaries = {
                   \ 'default' : '',
                   \ 'vimshell' : $HOME.'/.vimshell_hist',
                   \ 'scheme' : $HOME.'/.gosh_completions'
                   \ }

       " Define keyword.
       if !exists('g:neocomplete#keyword_patterns')
           let g:neocomplete#keyword_patterns = {}
       endif
       let g:neocomplete#keyword_patterns['default'] = '\h\w*'

       " Plugin key-mappings.
       inoremap <expr><C-g>     neocomplete#undo_completion()
       inoremap <expr><C-l>     neocomplete#complete_common_string()

       " Recommended key-mappings.
       " <CR>: close popup and save indent.
       inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
       function! s:my_cr_function()
           return neocomplete#close_popup() . "\<CR>"
           " For no inserting <CR> key.
           "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
       endfunction
       " <TAB>: completion.
       inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
       " <C-h>, <BS>: close popup and delete backword char.
       inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
       inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
       inoremap <expr><C-y>  neocomplete#close_popup()
       inoremap <expr><C-e>  neocomplete#cancel_popup()
       " Close popup by <Space>.
       "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

       " Enable omni completion.
       autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
       autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
       autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
       autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
       autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

       " Enable heavy omni completion.
       if !exists('g:neocomplete#sources#omni#input_patterns')
           let g:neocomplete#sources#omni#input_patterns = {}
       endif
       "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
       "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
       "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

       " For perlomni.vim setting.
       " https://github.com/c9s/perlomni.vim
       let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
   end " }}}

   if neobundle#tap('neosnippet') "{{{
       call neobundle#config({'autoload': {'unite_sources': ['neosnippet_file', 'snippet', 'snippet_target'], 'mappings': [['sxi', '<Plug>(neosnippet_']], 'commands': [{'complete': 'file', 'name': 'NeoSnippetSource'}, {'complete': 'customlist,neosnippet#filetype_complete', 'name': 'NeoSnippetMakeCache'}, {'complete': 'customlist,neosnippet#edit_complete', 'name': 'NeoSnippetEdit'}]}})
       " Plugin key-mappings.
       imap <C-k>     <Plug>(neosnippet_expand_or_jump)
       smap <C-k>     <Plug>(neosnippet_expand_or_jump)
       xmap <C-k>     <Plug>(neosnippet_expand_target)

       " SuperTab like snippets behavior.
       imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                   \ "\<Plug>(neosnippet_expand_or_jump)"
                   \: pumvisible() ? "\<C-n>" : "\<TAB>"
       smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                   \ "\<Plug>(neosnippet_expand_or_jump)"
                   \: "\<TAB>"

       " For snippet_complete marker.
       if has('conceal')
           set conceallevel=2 concealcursor=i
       endif

       " augroup RailsSnippets
       "     au!
       "     autocmd User Rails.view*                 NeoSnippetSource ~/.vim/snippet/ruby.rails.view.snip
       "     autocmd User Rails.controller*           NeoSnippetSource ~/.vim/snippet/ruby.rails.controller.snip
       "     autocmd User Rails/db/migrate/*          NeoSnippetSource ~/.vim/snippet/ruby.rails.migrate.snip
       "     autocmd User Rails/config/routes.rb      NeoSnippetSource ~/.vim/snippet/ruby.rails.route.snip
       " augroup END
   endif
end "}}}


if neobundle#tap('tcomment_vim') " {{{
  let g:tcommentMapLeaderOp1='go'
  let g:tcommentMapLeaderOp2='gO'
end "}}}


if neobundle#tap('vimshell.vim') " {{{
    call neobundle#config({
                \   'autoload' : {
                \     'commands' : [ 'VimShell', 'VimShellPop' ]
                \   }
                \ })
    function! neobundle#tapped.hooks.on_source(bundle)
        if neobundle#is_installed('vimshell-pure.vim')
            call neobundle#source('vimshell-pure.vim')
        endif
    endfunction

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

    call neobundle#untap()
endif " }}}

if neobundle#tap('vim-alignta') " {{{
    call neobundle#config({
        \   'autoload' : {
        \     'commands' : [ 'Align' ]
        \   }
        \ })
    " function! neobundle#tapped.hooks.on_source(bundle)
    " endf
    vnoremap <silent> => :Align @1 =><CR>
    vnoremap <silent> = :Align @1 =<CR>
    vnoremap <silent> == =
endif "}}}

if neobundle#tap('vim-operator-replace') "{{{
    call neobundle#config({'depends': 'vim-operator-user', 'autoload': {'mappings': ['<Plug>(operator-replace)']}})
    map R <Plug>(operator-replace)
end "}}}
if neobundle#tap('vim-operator-mdurl') "{{{
    call neobundle#config({'depends': 'vim-operator-user',
                \ 'autoload': {'mappings': ['<Plug>(operator-mdurl)', '<Plug>(operator-mdurlp)']}})
    map L <Plug>(operator-mdurl)
    map M <Plug>(operator-mdurlp)
end "}}}

if neobundle#tap('vim-surround') "{{{
  call neobundle#config({
   \ 'depends': 'vim-repeat',
   \ 'autoload': {'mappings': ['<Plug>Ysurround', '<Plug>Csurround', '<Plug>Ygsurround', '<Plug>Dsurround', ['i', '<Plug>ISurround'], ['sx', '<Plug>VgSurround'], ['sx', '<Plug>Vsurround'], '<Plug>SurroundRepeat', '<Plug>Yssurround', ['i', '<Plug>Isurround'], ['sx', '<Plug>Vgsurround'], '<Plug>Ygssurround', ['sx', '<Plug>VSurround']]}})
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:surround_no_mappings = 1
  endfunction
  nmap s <Plug>Ysurround
  nmap ss <Plug>Yssurround
endif "}}}

if neobundle#tap('yanktmp.vim') "{{{
    map <silent> sy :call YanktmpYank()<CR>
    map <silent> sp :call YanktmpPaste_p()<CR>
    map <silent> sP :call YanktmpPaste_P()<CR>
endif "}}}


if neobundle#tap('vim-mlh') "{{{
    call neobundle#config({
        \ 'depends': ['webapi-vim', 'skk.vim'],
        \ 'autoload': {'insert': 1, 'mappings':['<Plug>(vim_mlh']}})
    let g:skk_control_j_key = ""
    let g:skk_large_jisyo = "$HOME/local/dict/SKK-JISYO.L"
    imap <C-b> <Plug>(vim_mlh-i_retransliterate)<C-n>
    nmap <C-b> <Plug>(vim_mlh-retransliterate)<C-n>
end "}}}

if neobundle#tap('quickrun') "{{{
    call neobundle#config({
        \ 'autoload' : {
        \ 'mappings': ['<Plug>(quickrun)']
        \ }})
    let g:quickrun_config = {}
    let g:quickrun_config['javascript'] = {
          \ 'command': 'node',
          \ 'tempfile': '%{tempname()}.js'
          \ }


    augroup AddFileType
        autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
    augroup END

    " quickrunの設定
    let g:quickrun_config = {}
    let g:quickrun_config['*'] = {'runmode': "async:vimproc"}
    let g:quickrun_config['ruby.rspec'] = {'command': 'rspec', 'cmdopt': "-l %{line('.')}", 'exec': ['bundle exec %c %s %a']}

    silent! nmap ,r <Plug>(quickrun)
end "}}}

if neobundle#tap('JavaScript-Indent') "{{{
    call neobundle#config({
        \ 'autoload' : {
        \ 'filetypes': ['javascript']
        \ }})
end "}}}

if neobundle#tap('qfixhowm') "{{{
    let QFixHowm_Key      = 'g'
    let howm_dir          = $HOME . '/Dropbox/howm'
    let QFixHowm_RootDir  = $HOME . '/Dropbox/howm'
    let howm_filename     = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
    let howm_fileencoding = 'utf8'
    let howm_fileformat   = 'unix'
    let g:QFixHowm_TitleListCache = 0
    nmap g, [howm]
end "}}}

if !exists('loaded_matchit')
    source $VIMRUNTIME/macros/matchit.vim
endif
if neobundle#tap('hl_matchit.vim') "{{{
    let g:hl_matchit_enable_on_vim_startup = 1
    let g:hl_matchit_speed_level = 1
    let g:hl_matchit_allow_ft = 'html,vim,ruby'
end "}}}


if neobundle#tap('switch.vim') " {{{
    function! s:separate_defenition_to_each_filetypes(ft_dictionary) "{{{
      let result = {}

      for [filetypes, value] in items(a:ft_dictionary)
        for ft in split(filetypes, ",")
          if !has_key(result, ft)
            let result[ft] = []
          endif

          call extend(result[ft], copy(value))
        endfor
      endfor

      return result
    endfunction"}}}

    let s:switch_definition = {
          \ '*': [
          \   ['is', 'are']
          \ ],
          \ 'ruby,eruby,haml' : [
          \   ['if', 'unless'],
          \   ['while', 'until'],
          \   ['.blank?', '.present?'],
          \   ['include', 'extend'],
          \   ['class', 'module'],
          \   ['.inject', '.delete_if'],
          \   ['.map', '.map!'],
          \   ['attr_accessor', 'attr_reader', 'attr_writer'],
          \ ],
          \ 'Gemfile,Berksfile' : [
          \   ['=', '<', '<=', '>', '>=', '~>'],
          \ ],
          \ 'ruby.application_template' : [
          \   ['yes?', 'no?'],
          \   ['lib', 'initializer', 'file', 'vendor', 'rakefile'],
          \   ['controller', 'model', 'view', 'migration', 'scaffold'],
          \ ],
          \ 'erb,html,php' : [
          \   { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' },
          \ ],
          \ 'rails' : [
          \   [100, ':continue', ':information'],
          \   [101, ':switching_protocols'],
          \   [102, ':processing'],
          \   [200, ':ok', ':success'],
          \   [201, ':created'],
          \   [202, ':accepted'],
          \   [203, ':non_authoritative_information'],
          \   [204, ':no_content'],
          \   [205, ':reset_content'],
          \   [206, ':partial_content'],
          \   [207, ':multi_status'],
          \   [208, ':already_reported'],
          \   [226, ':im_used'],
          \   [300, ':multiple_choices'],
          \   [301, ':moved_permanently'],
          \   [302, ':found'],
          \   [303, ':see_other'],
          \   [304, ':not_modified'],
          \   [305, ':use_proxy'],
          \   [306, ':reserved'],
          \   [307, ':temporary_redirect'],
          \   [308, ':permanent_redirect'],
          \   [400, ':bad_request'],
          \   [401, ':unauthorized'],
          \   [402, ':payment_required'],
          \   [403, ':forbidden'],
          \   [404, ':not_found'],
          \   [405, ':method_not_allowed'],
          \   [406, ':not_acceptable'],
          \   [407, ':proxy_authentication_required'],
          \   [408, ':request_timeout'],
          \   [409, ':conflict'],
          \   [410, ':gone'],
          \   [411, ':length_required'],
          \   [412, ':precondition_failed'],
          \   [413, ':request_entity_too_large'],
          \   [414, ':request_uri_too_long'],
          \   [415, ':unsupported_media_type'],
          \   [416, ':requested_range_not_satisfiable'],
          \   [417, ':expectation_failed'],
          \   [422, ':unprocessable_entity'],
          \   [423, ':precondition_required'],
          \   [424, ':too_many_requests'],
          \   [426, ':request_header_fields_too_large'],
          \   [500, ':internal_server_error'],
          \   [501, ':not_implemented'],
          \   [502, ':bad_gateway'],
          \   [503, ':service_unavailable'],
          \   [504, ':gateway_timeout'],
          \   [505, ':http_version_not_supported'],
          \   [506, ':variant_also_negotiates'],
          \   [507, ':insufficient_storage'],
          \   [508, ':loop_detected'],
          \   [510, ':not_extended'],
          \   [511, ':network_authentication_required'],
          \ ],
          \ 'rspec': [
          \   ['describe', 'context', 'specific', 'example'],
          \   ['before', 'after'],
          \   ['be_true', 'be_false'],
          \   ['get', 'post', 'put', 'delete'],
          \   ['==', 'eql', 'equal'],
          \   { '\.should_not': '\.should' },
          \   ['\.to_not', '\.to'],
          \   { '\([^. ]\+\)\.should\(_not\|\)': 'expect(\1)\.to\2' },
          \   { 'expect(\([^. ]\+\))\.to\(_not\|\)': '\1.should\2' },
          \ ],
          \ 'markdown' : [
          \   ['[ ]', '[x]']
          \ ]
          \ }

    let s:switch_definition = s:separate_defenition_to_each_filetypes(s:switch_definition)
    function! s:define_switch_mappings() "{{{
      if exists('b:switch_custom_definitions')
        unlet b:switch_custom_definitions
      endif

      let dictionary = []
      for filetype in split(&ft, '\.')
        if has_key(s:switch_definition, filetype)
          let dictionary = extend(dictionary, s:switch_definition[filetype])
        endif
      endfor

      if exists('b:rails_root')
        let dictionary = extend(dictionary, s:switch_definition['rails'])
      endif

      if has_key(s:switch_definition, '*')
        let dictionary = extend(dictionary, s:switch_definition['*'])
      endif

      " if !empty('dictionary')
      "   call alpaca#let_b:('switch_custom_definitions', dictionary)
      " endif
    endfunction"}}}

    augroup SwitchSetting
      autocmd!
      autocmd Filetype * if !empty(split(&ft, '\.')) | call <SID>define_switch_mappings() | endif
    augroup END

    nnoremap - :Switch<cr>
endif "}}}

if neobundle#tap('vim-raiils') " {{{
    let g:rails_default_file='config/database.yml'
    let g:rails_level = 4
    let g:rails_mappings=1
    let g:rails_modelines=0
    " let g:rails_some_option = 1
    " let g:rails_statusline = 1
    " let g:rails_subversion=0
    " let g:rails_syntax = 1
    " let g:rails_url='http://localhost:3000'
    " let g:rails_ctags_arguments='--languages=-javascript'
    " let g:rails_ctags_arguments = ''
    function! SetUpRailsSetting()
    nnoremap <buffer><Space>r :R<CR>
    nnoremap <buffer><Space>a :A<CR>
    nnoremap <buffer><Space>m :Rmodel<Space>
    nnoremap <buffer><Space>c :Rcontroller<Space>
    nnoremap <buffer><Space>v :Rview<Space>
    nnoremap <buffer><Space>p :Rpreview<CR>
    endfunction
    aug MyRailsVimAutoCmd
        au!
        au User Rails call SetUpRailsSetting()
    aug END
    aug RailsDictSetting
        au!
    aug END
endif "}}}

if neobundle#tap('vim-endwise') " {{{
    call neobundle#config({'autoload': {'insert':1}})
endif "}}}

if neobundle#tap('unite-rails') " {{{
    call neobundle#config({
        \ 'depends': ['unite.vim'],
        \ 'autoload': {'commands':['Unite', "UniteWithBufferDir", "UniteWithCurrentDir"]}
        \})
    nnoremap [unite_rails] <Nop>
    nmap U [unite_rails]
    nnoremap [unite_rails]v :<C-U>Unite rails/view<CR>
    nnoremap [unite_rails]m :<C-U>Unite rails/model<CR>
    nnoremap [unite_rails]c :<C-U>Unite rails/controller<CR>
    nnoremap [unite_rails]s :<C-U>Unite rails/spec<CR>
    nnoremap [unite_rails]g :<C-U>Unite rails/bundled_gem<CR>
    nnoremap [unite_rails]a :<C-U>Unite rails/view rails/model rails/controller<CR>
endif "}}}

if neobundle#tap('vim-ref') " {{{
    nnoremap [vimref_rails] <Nop>
    nmap ,,r [vimref_rails]
    nnoremap [vimref_rails]a :<C-U>Unite source -input=ref<CR>
    nnoremap [vimref_rails]m :<C-U>Unite ref/man<CR>
endif "}}}

if neobundle#tap('vim-ref-ri') " {{{
    nnoremap [vimref_rails]r :<C-U>Unite ref/ri<CR>
endif "}}}

if neobundle#tap('vim-rspec') "{{{
    function! neobundle#tapped.hooks.on_source(bundle)
       let g:rspec_command = 'Dispatch rspec {spec}'
    endfunction


    nmap ,tc :call RunCurrentSpecFile()<CR>
    nmap ,tn :call RunNearestSpec()<CR>
    nmap ,tl :call RunLastSpec()<CR>
    nmap ,ta :call RunAllSpecs()<CR>
endif "}}}

"}}}


" mappings. {{{2

syntax on
filetype plugin indent on

"" key mapping

" open new window vertical split when use gf.
nnoremap gf :vsplit<CR>gf
nnoremap gF <C-W>gf

inoremap <C-j> <ESC>
cnoremap <C-j> <ESC>

inoremap <C-l> <C-x><C-l>

" move faster cursor for me
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
nnoremap T :tabe<CR>

nnoremap : q:a
nnoremap / q/a

nnoremap <C-h> :noh<CR>


noremap ,ev :e ~/.vimrc<CR>
noremap ,re :source ~/.vimrc<CR>:echo 'reload .vimrc!!'<CR>

" for paste
noremap ,v :r! cat -<CR>

" reselect paste resion
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" paste yanked string vertically
vnoremap <C-p> I<C-r>"<ESC><ESC>

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

" sync unnamed register and *register.
set clipboard=unnamed

" searching.
set ignorecase
set smartcase
set hlsearch
set incsearch

set autoread
set noswapfile

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


command! Utf8 :e ++enc=utf8<CR>
command! EucJP :e ++enc=euc-jp<CR>
command! Cp932 :e ++enc=cp932<CR>
command! FencUtf8 :set fenc=utf8<CR>
command! FencEUC :set fenc=euc-jp<CR>
command! FencCp932 :set fenc=cp932<CR>

" command! DeleteAlert :g/alert(/d
" command! DeleteConsole :g/console.\(log\|debug\)/d

function! SetColumnWidthLimit()
  setlocal textwidth=78
  if exists('+colorcolumn')
    setlocal colorcolumn=+1
  endif
endfun

au Filetype perl,javascript,vim,ruby call SetColumnWidthLimit()

augroup WriteRuby
  autocmd!
  au Filetype ruby setlocal tabstop=2
  au Filetype ruby setlocal shiftwidth=2
augroup END

" カーソル行を強調表示しない
" 挿入モードの時のみ、カーソル行をハイライトする
autocmd InsertEnter * set cursorline!
autocmd InsertLeave * set nocursorline
" lazy load を呼び出してしまわないとハイライトされないので実行
doautocmd InsertEnter
doautocmd InsertLeave



noremap ,trim :call RTrim()<CR>:echo 'trim space!'<CR>
function! RTrim()
    let s:cursor = getpos(".")
    %s/\s\+$//e
    call setpos(".", s:cursor)
endfunction

" multibyte space highlighting.
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
endf

" syntaxの有無をチェックし、新規バッファと新規読み込み時にハイライトさせる
if has("syntax")
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif

xmap ah  <Plug>(textobj-url-a)
omap ah  <Plug>(textobj-url-a)
xmap ih  <Plug>(textobj-url-i)
omap ih  <Plug>(textobj-url-i)

xmap au  <Plug>(textobj-wiw-a)
omap au  <Plug>(textobj-wiw-a)
xmap iu  <Plug>(textobj-wiw-i)
omap iu  <Plug>(textobj-wiw-i)
