" vim: set foldmethod=marker foldlevel=0:
" Vimrc and gVimrc file

" ===============================================================
" System Information {{{
" ===============================================================
if has('win32') || has('win16')
  let s:os = 'windows'
  let s:VIMFILES = $HOME . '/vimfiles'
elseif has('unix')
  let s:os = substitute(system('uname'), '\n', '', '')
  let s:VIMFILES = $HOME . '/.vim'
else
  let s:os = 'undefined'
  let s:VIMFILES = $HOME . '/.vim'
endif
" }}}

let g:mapleader = ','
" ===============================================================
" Settings {{{
" ===============================================================
" vint: -ProhibitSetNoCompatible
set nocompatible            " be iMproved!

set autochdir
set autoindent
set background=dark
set backspace=indent,eol,start
set diffopt=filler,vertical
set foldlevel=0
set foldmethod=marker
set gdefault                " Add g flag to search/replace
set hidden                  " Buffers finally don't suck
set history=10000
set hlsearch                " highlights search results
set ignorecase smartcase    " case insensitive for all-lower searches
set incsearch               " searches as you type
set lazyredraw
set modelines=0             " Security reasons
set nobackup                " no annoying file.txt~ files
set nojoinspaces            " Only insert a single space after punctuation
set noshowmode              " Handled by airline
set number numberwidth=1
set ruler
set scrolloff=4             " keep at least 4 lines above/below
set showcmd
set sidescrolloff=4         " keep at least 4 lines left/right
set smartindent
set splitbelow
set t_Co=256
set t_ut=
set textwidth=80
set timeoutlen=1000         " But still give me time to enter leader commands
set ttimeoutlen=200         " Exit insert mode quickly
set undolevels=1000
set undofile                " Preserve undo history between sessions
set virtualedit=block       " makes virtual blocks cleaner and blockier
set wildignore+=.DS_Store,*.swp,*.bak,*.pyc,*.class,*.o,*.obj
set winaltkeys=no           " Don't let Windows eat the alt-key

" }}}

colorscheme fischer
syntax on
nohl                        " Default = don't highlight

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" ===============================================================
" vim-plug {{{
" ===============================================================

call plug#begin(s:VIMFILES . '/plugged')
if has('python')
  Plug 'Valloric/MatchTagAlways'
  Plug 'google/vim-codefmt', { 'on': ['FormatCode', 'FormatLines'] }
  Plug 'google/vim-codereview'
  Plug 'google/vim-glaive'
  Plug 'google/vim-maktaba'
endif
if has('nvim') " Requires neovim
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'neomake/neomake'
endif
Plug 'KabbAmine/gulp-vim'
Plug 'alunny/pegjs-vim'
Plug 'alvan/vim-closetag'
Plug 'chrisbra/unicode.vim'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'heavenshell/vim-pydocstring'
Plug 'junegunn/vim-emoji'
Plug 'luochen1990/rainbow'
Plug 'mattn/webapi-vim'
Plug 'moll/vim-node'
Plug 'nfischer/vim-marker', { 'frozen': 1 }
Plug 'nfischer/vim-ohm'
Plug 'nfischer/vim-potigol'
Plug 'nfischer/vim-rainbows'
Plug 'nfischer/vim-vimignore'
Plug 'pangloss/vim-javascript'
Plug 'rgrinberg/vim-ocaml'
Plug 'roryokane/detectindent'
Plug 'suy/vim-context-commentstring'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive' | let s:fugitive_loaded = 1
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'wlangstroth/vim-racket'
" Plug 'airblade/vim-gitgutter'
" Plug 'altercation/vim-colors-solarized'
" Plug 'ap/vim-buftabline'
" Plug 'bpowell/vim-android'
" Plug 'hsanson/vim-android'
" Plug 'klen/python-mode'
" Plug 'syngan/vim-vimlint'
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
" Plug 'w0ng/vim-hybrid'
call plug#end()

" }}}
" ===============================================================
" Plugin settings {{{
" ===============================================================

" let g:solarized_termcolors=256
" colorscheme hybrid
if has('nvim')
  let g:deoplete#enable_at_startup = 1

  let g:neomake_javascript_enabled_makers = ['eslint']
  augroup Neomake
    au!
    au BufEnter,BufWritePost * Neomake
  augroup END
endif

" Rainbows-lang ftplugin
let g:rainbows#inferencer_path = '/home/nate/programming/rainbows/bin/rain-infer.js'

" Rainbow parens
let g:rainbow_active = 0
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}
let g:pydocstring_enable_mapping = 0

" Airline settings
set laststatus=2

" PatienceDiff settings
if v:version >= 704
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

" Built-in plugins
runtime ftplugin/man.vim
filetype plugin on

" DetectIndent settings
augroup DetectIndent
  autocmd!
  autocmd BufReadPost * DetectIndent
augroup END

" Fugitive settings
if exists('s:fugitive_loaded')
  nnoremap <silent> <leader>gs  :<C-u>Gstatus<CR>
  nnoremap <silent> <leader>ga  :<C-u>Gwrite<CR>
  nnoremap <silent> <leader>gc  :<C-u>Gcommit<CR>
  nnoremap <silent> <leader>gps :<C-u>Gpush<CR>
  nnoremap <silent> <leader>gd  :<C-u>Gdiff<CR>
  nnoremap <silent> <leader>ghh :<C-u>Gdiff HEAD<CR>
  nnoremap <silent> <leader>gH  :<C-u>Gdiff HEAD<CR>
  nnoremap <silent> <leader>gh1 :<C-u>Gdiff HEAD~1<CR>
  nnoremap          <leader>gh  :<C-u>Gdiff HEAD~
  nnoremap <silent> <leader>gpc :<C-u>Git pc<CR>
  nnoremap <silent> <leader>gb  :<C-u>Gblame<CR>
  nnoremap <silent> <leader>gi  :<C-u>GEditIgnore<CR>
endif

" Vundle mappings
nnoremap <silent> <leader>vu :<C-u>PlugUpdate<CR>
nnoremap <silent> <leader>vi :<C-u>PlugInstall<CR>

" Tmux mappings
nnoremap <silent> <Left>    :TmuxNavigateLeft<cr>
nnoremap <silent> <Down>    :TmuxNavigateDown<cr>
nnoremap <silent> <Up>      :TmuxNavigateUp<cr>
nnoremap <silent> <Right>   :TmuxNavigateRight<cr>

" }}}
" ===============================================================
" Indentation and word wrapping {{{
" ===============================================================
if !exists('s:has_set_indent')
  set shiftwidth=2 tabstop=2 softtabstop=2
  set expandtab
  set smarttab
  let s:has_set_indent = 1
endif

" Fix smartindent stupidities
" And no magic outdent for comments
inoremap # X<C-H>#
nnoremap <silent> >> :call ShiftLine()<CR>| " And no shift magic on comments
function! ShiftLine()
  let l:oldsi=&smartindent
  set nosmartindent
  normal! >>
  let &smartindent=l:oldsi
endfunction

vnoremap < <gv
vnoremap > >gv

" Format options to wordwrap properly, but not auto-comment
"set lbr
if v:version < 704
  set formatoptions=qnl      " Add the options I want
else
  set formatoptions=qnlj
endif
" Autocommenting is removed by a plugin

" }}}

" Configure the mouse (scrolling only)
set mouse=a
noremap  <LeftMouse>   <nop>
noremap  <LeftRelease> <nop>
noremap  <RightMouse>  <nop>
inoremap <LeftMouse>   <nop>
inoremap <LeftRelease> <nop>
inoremap <RightMouse>  <nop>

if has('gui_running')
  " GUI specific
  set noerrorbells visualbell t_vb=
  set guioptions=T

  " Select columns better with gg & G in visual mode
  " Note: set nosol interferes with DRAG_VISUALS in console vim
  set nostartofline
  nnoremap <silent> <C-v> :set nosol<CR><C-v>
  vnoremap <silent> <ESC> <ESC>:set sol<CR>
endif

" ===============================================================
" 'directory' and 'undodir' {{{
" ===============================================================
let s:prefix = s:os ==# 'windows' ? '%TMP%\' : '~/.vim/'
exe 'set directory=' . s:prefix . 'tmp,.'
exe 'set directory=' . s:prefix . 'undodir,.'
if !isdirectory(expand(s:prefix . 'tmp'))
  call mkdir(expand(s:prefix . 'tmp'), 'p')
endif
if !isdirectory(expand(s:prefix . 'undodir'))
  call mkdir(expand(s:prefix . 'undodir'), 'p')
endif
" }}}
"==== Capslock ===="
" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for s:c in range(char2nr('A'), char2nr('Z'))
  exe 'lnoremap ' . nr2char(s:c+32) . ' ' . nr2char(s:c)
  exe 'lnoremap ' . nr2char(s:c) . ' ' . nr2char(s:c+32)
endfor

" ===============================================================
" Key mappings {{{
" ===============================================================
" Swap : and ;
noremap  ;  :
noremap  <Bslash>  ;

" Force tmux to respect <C-a>
cnoremap  <C-a> <home>

" Prevents annoying behavior
nnoremap          Q     <nop>
nnoremap          <C-z> <nop>
nnoremap <silent> K     k:echoerr 'CAPSLOCK IS ON'<CR>
nnoremap <silent> J     j:echoerr 'CAPSLOCK IS ON'<CR>
vnoremap <silent> K     k:<C-u>echoerr 'CAPSLOCK IS ON'<CR>gv
vnoremap <silent> J     j:<C-u>echoerr 'CAPSLOCK IS ON'<CR>gv
cnoremap          q~    q!
cnoremap          q1    q!

nnoremap <silent> cn :cnext<CR>
nnoremap <silent> cp :cprevious<CR>

" Treat long lines as break lines
nnoremap j  gj
nnoremap k  gk
nnoremap gj j
nnoremap gk k

" This is a tmux workaround to allow me to redraw the screen with
" <prefix-key><C-l>
nnoremap <silent> <leader>ll :<C-u>nohl<CR><C-l>

" <C-a> highlights all, + will increment numbers
nnoremap + <C-a>
nnoremap <C-a> ggVG

" Adjust yanking to be more consistent with other conventions
nnoremap Y y$

" Spell checking
if exists('+spelllang')
  set spelllang=en_us
endif
nnoremap <silent> <leader>sp :setlocal spell!\|set spell?<CR>
vnoremap <silent> <leader>sp :<C-u>setlocal spell!<CR>gv
inoremap <C-l> <Esc>[s1z=`]a
" }}}
" ===============================================================
" Instantly Better Vim additions {{{
" ===============================================================

"====[ Make the 81st column stand out ]===="

hi ColorColumn  gui=bold guifg=black guibg=magenta cterm=bold ctermfg=black
   \ ctermbg=magenta
augroup HilightColumn
  autocmd!
  autocmd BufEnter,WinEnter * call matchadd('ColorColumn', '\%81v', 100)
augroup END

"====[ Highlight matches when jumping to next ]===="
" nnoremap <silent> n   n:call HLNext(0.15)<CR>
" nnoremap <silent> N   N:call HLNext(0.15)<CR>
nnoremap <silent> '   :call HLGoto(0.15)<CR>
nnoremap ` '

function! Blink(blinks, blinktime, blinkcmd, unblinkcmd)
  let l:sleep_cmd =  'sleep ' . float2nr(a:blinktime * 1000 / a:blinks) . 'm'
  for l:n in range(1, a:blinks)
    exe a:blinkcmd | redraw | exe l:sleep_cmd
    exe a:unblinkcmd | redraw | exe l:sleep_cmd
  endfor
endfunction

" OR ELSE just highlight the match in red
hi WhiteOnRed guifg=white guibg=red ctermfg=white ctermbg=red
function! HLNext(blinktime)
  let l:col = col('.')
  let l:matchlen = strlen(matchstr(strpart(getline('.'),l:col-1),@/))
  let l:target_pat = '\c\%#'.@/
  let l:blinks = 4
  let l:sleep_cmd =  'sleep ' . float2nr(a:blinktime * 1000/ l:blinks) . 'm'
  for l:n in range(1,l:blinks)
    let l:ring = matchadd('WhiteOnRed', l:target_pat, 101)
    redraw | exe l:sleep_cmd
    call matchdelete(l:ring)
    redraw | exe l:sleep_cmd
  endfor
endfunction

function! HLGoto(blinktime)
  " Go to
  try
    let l:c = nr2char( getchar() )
    exe 'normal! `' . l:c
  catch /.*/
    let l:msg = substitute(v:exception, '\m\C^Vim(.*):\(.*\)$', '\1', '')
    echohl ErrorMsg | echo l:msg | echohl NONE
    return
  endtry
  " Blink
  let s:oldcursorline=&cursorline
  set nocursorline
  call Blink(4, a:blinktime, 'set cursorline!', 'set cursorline!')
  " Restore cursorline setting
  let &cursorline=s:oldcursorline
endfunction

" Move a single char left or right
function! MoveChar(dir)
  let l:at_last_col = col('.') == col('$')-1
  let l:is_left = a:dir ==# 'left'
  if l:is_left && col('.') == 1 || !l:is_left && l:at_last_col
    return ''
  elseif l:is_left && l:at_last_col
    return 'xP'
  elseif l:is_left " and not at last column
    return 'xhP'
  else
    return 'xp' " move right
  endif
endfunction
nmap  <expr>  <C-LEFT>   MoveChar('left')
nmap  <expr>  <C-RIGHT>  MoveChar('right')

"==== Use a plugin from Instantly Better Vim to drag visual blocks ===="
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
let g:DVB_TrimWS = 1

"==== Changes list from comma separated to bulleted and back ===="
nmap  <leader>lt  :call ListTrans_toggle_format()<CR>
vmap  <leader>lt  :call ListTrans_toggle_format('visual')<CR>

"==== Do some math on columns. Instantly better vim ===="
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

" }}}
" ===============================================================
" Leader functions {{{
" ===============================================================

" Times the number of times a particular command takes to execute the specified
" number of times (in seconds).
function! HowLong(number_of_times, ...)
  " We don't want to be prompted by a message if the command being tried is
  " an echo as that would slow things down while waiting for user input.
  let l:command = join(a:000)
  echo 'Running "' . l:command . '" ' . a:number_of_times . ' times'

  let l:old_more = &more
  set nomore
  let l:start_time = localtime()
  for l:i in range(a:number_of_times)
    exe l:command
  endfor
  let l:result = localtime() - l:start_time
  let &more = l:old_more
  return l:result
endfunction

function! AlphaArgs(num)
  let l:alpha_args = join(split('abcdefghijklmnopqrstuvwxyz', '\zs')[0:a:num-1], ', ')
  exe 'normal! ci)' . l:alpha_args
endfunction

" Let's insert some line numbers (explicitly in the text)
function! Numberify()
  let l:num = getpos('.')[1]
  exe 'normal! I' . l:num . '. '
endfunction

function! DecreaseLineNums(...)
  if exists('a:1')
    let l:dec_count = a:1
  else
    let l:dec_count = 1
  endif
  if l:dec_count < 0
    let l:dec_count = l:dec_count * -1
    let l:cmd = "\<C-a>"
  else
    let l:cmd = "\<C-x>"
  endif
  for l:k in range(l:dec_count)
    exe 'normal! 0' . l:cmd
  endfor
endfunction

function! ToggleTest() " for ShellJS/cash
  if getcwd() =~# 'src/commands'
    cd ..
    let l:new_dir = 'test'
  elseif getcwd() =~# 'src'
    let l:new_dir = 'test'
  elseif getcwd() =~# 'test'
    let l:new_dir = 'src'
    if isdirectory('../src/commands/')
      let l:new_dir = l:new_dir . '/commands'
    endif
  else
    " error
    echohl ErrorMsg | echo "Can't find your directory" | echohl NONE
    return 1
  endif
  exe 'edit ../' . l:new_dir . '/' . expand('%:t')
endfunction

function! GenerateDocs() " for ShellJS
  let l:old_cwd = getcwd()
  let l:start_dir = l:old_cwd
  while !isdirectory('scripts/')
    cd ..
    let l:new_cwd = getcwd()
    if l:new_cwd == l:old_cwd
      echohl ErrorMsg | echo 'Unable to find scripts/ dir' | echohl NONE
      return 1
    endif
    let l:old_cwd = l:new_cwd
  endwhile
  !scripts/generate-docs.js
  exe 'cd ' . l:start_dir
endfunction

function! Transpile()
  function! RefreshOutputBuf(content)
  endfunction
  let l:js_output = system('node bin/transpile.js input.sh')
  let l:old_frame = winnr()
  let l:old_syn = &syntax
  if !bufloaded('OUTPUT')
    " Create a new scratch buffer
    silent botright vnew OUTPUT
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal noswapfile
    set filetype=javascript
  else
    let l:output_win = winnr('$')
    exe l:output_win . 'wincmd w'
  endif
  normal! ggdG
  put!=l:js_output
  exe l:old_frame . 'wincmd w'
  if !empty(&syntax)
    syntax on
  endif
endfunction

function! RenameTokenFunction(orig, new) range
  if a:orig ==# a:new
    echoerr 'These are the same thing!'
  endif

  let l:reset_pos = 1
  if !search('\<' . a:orig . '\>', 'nw')
    let l:reset_pos = 0
  endif

  " Do a global replace
  let l:old_search = getreg('/')
  let l:old_gdefault = &gdefault
  set nogdefault
  silent exe a:firstline . ',' . a:lastline . 's/\C\<' . a:orig . '\>/' . a:new
      \ . '/g'
  let &gdefault = l:old_gdefault
  echo a:orig . ' -> ' . a:new
  call setreg('/', l:old_search)
endfunction

" a:orig is the original indent, and a:new is the preferred new indent
function! ChangeIndentFunc(orig, new)
  let l:old_et = &expandtab
  exe 'set ts=' . a:orig . ' sts=' . a:orig . ' noet'
  retab!
  exe 'set ts=' . a:new . ' sts=' . a:new . ' sw=' . a:new
  if (l:old_et)
    set expandtab
  endif
  retab
endfunction

function! MoveSplit(dir)
  let l:left_cmd  = 'vertical resize -5'
  let l:right_cmd = 'vertical resize +5'
  if (winnr() == 1 && a:dir ==# 'left') ||
      \ (winnr() == winnr('$') && a:dir !=# 'left')
    exe l:left_cmd
  else
    exe l:right_cmd
  endif
endfunction

" vint: -ProhibitCommandWithUnintendedSideEffect
" vint: -ProhibitCommandRelyOnUser
function! FixWhiteSpace()
  let l:old_cursor = getpos('.')
  let l:old_search = getreg('/')
  %s/\s\+$//e
  call setpos('.', l:old_cursor)
  call setreg('/', l:old_search)
endfunction

function! DrawBox()
  normal! yy2p
  s/+/\|/eg
  s/-/ /eg
  nohl
endfunction
" vint: +ProhibitCommandWithUnintendedSideEffect
" vint: +ProhibitCommandRelyOnUser

function! AddTodo(msg)
  let l:todo_str = 'TODO(' . $USER . '): ' . a:msg
  if &commentstring !~# '\v^.+ \%s'
    let l:todo_str = ' ' . l:todo_str
  endif
  let l:full_text = substitute(&commentstring, '%s', l:todo_str, '')
  let l:line_text = getline('.')
  let l:indent = matchstr(l:line_text, '^\s*')
  put!=l:indent . l:full_text
endfunction

" TODO: Clean this up
function! RunProject(...)
  " Try to see if the current file is executable
  function! FindExecutables(path)
    return system('find ' . a:path . ' -type f -executable -print')
  endfunction
  if a:0 > 0
    let l:runtarget = a:1
  else
    let l:fname = expand('%:p')
    if empty(l:fname)
      let l:runtarget = ''
    else
      let l:runtarget = FindExecutables(l:fname)
    endif
    if empty(l:runtarget)
      " Search all open buffers for an executable file
      let l:executables = split(FindExecutables('*'), '\n')
      for l:e in l:executables
        if bufexists(l:e) || empty(l:runtarget)
          let l:runtarget = l:e
        endif
      endfor
    endif
  endif
  if empty(l:runtarget)
    let l:msg = 'Error: could not find a runtarget'
    echohl ErrorMsg | echomsg l:msg | echohl NONE
  else
    let l:full_path = fnamemodify(l:runtarget, ':p')
    exe 'silent !echo ' . l:full_path
    exe '!' . l:full_path
  endif
endfunction

"==== Edit .vimrc quickly ===="
function! EditConfigFile(config_name, ...)
  if !filewritable(a:config_name)
    let l:msg = a:config_name . " can't be edited"
    echohl ErrorMsg | echo l:msg | echohl NONE
  else
    let l:fname = expand('%:p')
    if line('$') == 1 && empty(getline(1)) && empty(l:fname)
      " We're not editing anything interesting, so open in a full window
      exe 'edit ' . a:config_name
    elseif l:fname ==# a:config_name && !exists('s:warned_for_file')
      let l:msg = 'Already editing ' . expand('%:t') . '. Try again to open'
      echohl WarningMsg | echo l:msg | echohl NONE
      let s:warned_for_file = 1
    else
      exe 'vsp ' . a:config_name
    endif
    " Configure this buffer
    if !exists('a:1')
      set bufhidden=delete
    endif
  endif
endfunction

function! MakeExecutable(...)
  if has('unix')
    if a:0 == 0
      let l:fnames = expand('%:p')
    else
      let l:fnames = join(a:000) " Joins with a space
    endif
    let l:oldautoread = &l:autoread
    setlocal autoread
    call system('chmod +x ' . l:fnames)
    checktime
    let &l:autoread = l:oldautoread
  else
    echohl ErrorMsg
    echom "Error: This isn't a unix system"
    echohl NONE
  endif
endfunction

function! DeleteThisFile(...)
  if has('unix')
    let l:rm_cmd = 'rm'
  else
    let l:rm_cmd = 'del'
  endif
  if a:0 == 0
    " Delete the current file
    let l:file_name = shellescape(expand('%:p'))
    silent bdelete
    let l:cmd = l:rm_cmd . ' ' . l:file_name
  else
    let l:file_list = []
    for l:arg in a:000
      let l:arg = fnamemodify(l:arg, ':p')
      call add(l:file_list, l:arg)
    endfor
    let l:file_names = join(l:file_list)
    exe 'silent! bdel ' . l:file_names
    let l:cmd = l:rm_cmd . ' ' . l:file_names
  endif

  let l:output = system(l:cmd)
  if empty(l:output)
    let l:msg_string = l:cmd
  else
    let l:msg_string = l:output
  endif

  " Print command output in shell or vim, whichever makes sense
  if NumberOfBuffers() == 1 && empty(expand('%'))
    exe 'silent !echo ' . l:msg_string | quit! " In shell
  else
    " In vim if we have more buffers
    echo l:msg_string
  endif
endfunction

function! NumberOfBuffers()
  let l:highest = bufnr('$')
  let l:bufcount = 0
  for l:i in range(1, l:highest+1)
    if buflisted(l:i)
      let l:bufcount+=1
    endif
  endfor
  return l:bufcount
endfunction

function! SudoWriteFile()
  " This will write a file that is read-only, using sudo permission
  silent write !sudo tee % >/dev/null
endfunction

let s:open_cmd = ''
if s:os ==# 'Linux'
  let s:open_cmd = 'xdg-open'
elseif s:os ==# 'Darwin'
  let s:open_cmd = 'open'
endif " Windows?

function! InsertIFS()
  let l:lines = ['old_IFS=${IFS}', "IFS='", "'", 'IFS=${old_IFS}']
  for l:line in l:lines
    put=l:line
  endfor
endfunction

function! OpenFunction(...)
  for l:f in a:000
    echo l:f
    " asynchronously open l:f
    call system(s:open_cmd . ' ' . l:f . '&>/dev/null &')
  endfor
endfunction

function! WC_file(...)
  if (a:0 > 0)
    let l:output = system('wc '.a:1)
    let l:op_list = split(l:output)
  else
    let l:oldstatus = v:statusmsg
    exe "silent normal! g\<c-g>"
    try
      let s:word_count = str2nr(split(v:statusmsg)[11])
      let s:char_count = str2nr(split(v:statusmsg)[15])
      let v:statusmsg = l:oldstatus
      " Format: lines: x words: y chars: z
      let l:op_list = [line('$'), s:word_count, s:char_count]
    catch
      echo 'No file'
      return
    endtry
  endif
  highlight NormalUnderlined term=underline cterm=underline gui=underline
  echon 'lines: '
  echohl NormalUnderlined | echon l:op_list[0] | echohl NONE
  echon ' words: '
  echohl NormalUnderlined | echon l:op_list[1] | echohl NONE
  echon ' chars: '
  echohl NormalUnderlined | echon l:op_list[2] | echohl NONE
endfunction

function! WordCount(...)
  if a:0 == 0
    call WC_file() " No parameter
  else
    for l:f in a:000
      call WC_file(l:f)
      echon '   ' . l:f
      echo ''
    endfor
  endif
endfunction

" }}}
" ===============================================================
" Leader mappings {{{
" ===============================================================

nnoremap <silent> <leader>tt :call ToggleTest()<CR>
nnoremap <silent> <leader>gl :Gulp<CR>
nnoremap <silent> <leader>nt :!npm test<CR>
nnoremap <silent> <leader>tp :call Transpile()<CR>
nnoremap          <leader>sq ciwsquash<Esc>b
nnoremap          <leader>bu :b<Space>
nnoremap          <leader>rf :RenameToken <C-r><C-w><space>
vnoremap          <leader>rf :RenameToken<space>
nnoremap          <leader>vg :vimgrep<Space><C-r><C-W><Space>*<CR>
nnoremap <silent> <leader>qf :<C-u>cwindow<CR>
nnoremap <silent> <leader>C  :let &scrolloff=999-&scrolloff<CR>
noremap  <silent> <leader>ev :<C-u>call EditConfigFile($MYVIMRC)<CR>
noremap  <silent> <leader>ea :<C-u>call EditConfigFile(expand('~/.shell_aliases'))<CR>
noremap  <silent> <leader>eb :<C-u>call EditConfigFile(expand('~/.bashrc'))<CR>
noremap  <silent> <leader>ez :<C-u>call EditConfigFile(expand('~/.zshrc'))<CR>
noremap  <silent> <leader>et :<C-u>call
    \ EditConfigFile(expand('~/.tmux.conf'))<CR>
noremap  <silent> <leader>ep :<C-u>call EditConfigFile(expand('~/.profile'))<CR>
noremap  <silent> <leader>sv :<C-u>source $MYVIMRC<CR>
noremap  <silent> <leader>ef :<C-u>exe 'vsp ' . expand('<cfile>')<CR>
noremap  <silent> <leader>ec :<C-u>exe 'vsp ' . expand('<cfile>:r') . '.c'<CR>

noremap  <silent> <leader>rm :call DeleteThisFile()<CR>

nnoremap <silent> <leader>f  :echo expand('%')<CR>
nnoremap <silent> <leader>w  :<C-u>silent call FixWhiteSpace()<CR>

nnoremap <silent> <leader>sh :!true<CR>

" Run last make target
nnoremap <silent> <leader>m  :make<Up><CR>
nnoremap <silent> <leader>ru :call RunProject()<CR>

nnoremap          <leader>2  A >&2<ESC>
nnoremap <silent> <leader>i  :call InsertIFS()<CR>
nnoremap <silent> <leader>o  :Open %<CR>

nnoremap <silent> <leader>p  :Pandoc<CR>
nnoremap <silent> <leader>u  :call marker#Underline('-')<CR>
nnoremap <silent> <leader>U  :call marker#Underline('=')<CR>
nnoremap <silent> <leader>bo :call DrawBox()<CR>
" TODO: Put this in a command, in a plugin
nnoremap <silent> <leader>3  :Header 3<CR>
nnoremap <silent> <leader>4  :Header 4<CR>

" }}}
" ===============================================================
" Custom Commands {{{
" ===============================================================

command! -nargs=1 Alpha call AlphaArgs(<f-args>)
command! -complete=file -nargs=1 Browser !chromium-browser <args> &>/dev/null &
command! -nargs=0 Yank normal! ggVG"+y``
command! -nargs=0 Blast normal! ggVG"+p
command! -nargs=0 Gendocs call GenerateDocs()
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let l:expanded_cmdline = a:cmdline
  for l:part in split(a:cmdline, ' ')
     if l:part[0] =~# '\v[%#<]'
        let l:expanded_part = fnameescape(expand(l:part))
        let l:expanded_cmdline = substitute(l:expanded_cmdline, l:part, l:expanded_part, '')
     endif
  endfor
  botright vnew
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' . l:expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. l:expanded_cmdline
  setlocal nomodifiable
endfunction

com! -nargs=0                         LongLines call setreg('/', '\m^.\{81,}$')|
    \ echo 'press n to go to the next long line'
com! -nargs=1                         Todo call AddTodo(<q-args>)
com! -nargs=*                         RunProject call RunProject(<f-args>)
com! -nargs=+ -complete=command       Profile echo HowLong(<f-args>)

"  TODO(nate): Move this into a separate plugin
com! -nargs=* -complete=var -range=%  RenameToken <line1>,<line2>
    \ call RenameTokenFunction(<f-args>)

com! -nargs=+                         ChangeIndent
    \ call ChangeIndentFunc(<f-args>)
com! -nargs=0                         Fn echo expand('%')

" Make this file executable
com! -nargs=* -complete=file          Chmod call MakeExecutable(<f-args>)

" Enable saving read-only files using sudo
com! -nargs=0                         W call SudoWriteFile()

" Enable opening a file using vim
com! -nargs=+ -complete=file          Open call OpenFunction(<f-args>)

" Unixy things
com! -nargs=+ -complete=file          Rm call DeleteThisFile(<f-args>)
com! -nargs=* -complete=file          Ls echo system('ls --color=auto ' . <q-args>)
com! -nargs=* -complete=file          Wc call WordCount(<f-args>)

" }}}
" ===============================================================
" JumpCursorOnEdit {{{
" ===============================================================
" Restore cursor position to where it was before
function! s:JumpToLastPosition(fname)
  if expand(a:fname . ':p:h') !=? $TEMP
    if line("'\"") > 1 && line("'\"") <= line('$')
      let l:last_line = line("'\"")
      let b:doopenfold = 1
      if (foldlevel(l:last_line) > foldlevel(l:last_line - 1))
        let b:doopenfold = 2
      endif
      normal! `"
      if b:doopenfold == 2
        normal! k
      endif
    endif
  endif
endfunction

" Need to postpone using 'zv' until after reading the modelines.
function! s:OpenFolds()
  if exists('b:doopenfold')
    exe 'normal! zv'
    if(b:doopenfold > 1)
      exe  '+'.1
    endif
    unlet b:doopenfold
  endif
endfunction

augroup JumpCursorOnEdit
  autocmd!
  autocmd BufReadPost,BufWinEnter * call s:JumpToLastPosition('<afile>')
  autocmd BufWinEnter * call s:OpenFolds()
augroup END
" }}}

"==== Make tabs, trailing whitespace, and non-breaking spaces visible, but not in insert mode ===="

" vint: -ProhibitUnnecessaryDoubleQuote
exe "set listchars=tab:\uB6~,trail:\uB7,nbsp:~"
" vint: +ProhibitUnnecessaryDoubleQuote
set list

"==== Vim Window setup ===="
nnoremap <silent> <C-w>h :call MoveSplit('left')<CR>
nnoremap <silent> <C-w>l :call MoveSplit('right')<CR>

" ===============================================================
" Autocommands {{{
" ===============================================================

"==== Skeleton/template files ===="
augroup Skeleton
  function! s:LoadSkeleton()
    let l:fname = s:VIMFILES . '/templates/skeleton.' . &filetype
    if filereadable(l:fname)
      silent! exe '0r ' . l:fname | setlocal modified
    endif
  endfunction
  autocmd!
  autocmd BufNewFile * call s:LoadSkeleton()
augroup END

"==== Reload vimrc whenever it's saved ===="
augroup ConfigReload
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"==== No damn blinking lights! ===="
augroup ErrorBells
  autocmd!
  autocmd GUIEnter * set vb t_vb=
augroup END

"====[ Open any file with a pre-existing swapfile in readonly mode ]===="
augroup NoSimultaneousEdits
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
  autocmd SwapExists * echohl ErrorMsg
  autocmd SwapExists * echomsg 'Duplicate edit session (readonly)'
  autocmd SwapExists * echohl NONE
  autocmd SwapExists * sleep 1
augroup END

augroup FileTypeOptions
  " Configure comment patterns and other things
  autocmd!
  autocmd FileType c,cpp,cs,java,markdown   setlocal commentstring=//\ %s
  autocmd FileType bash,python              setlocal commentstring=#\ %s
  autocmd FileType vim                      setlocal commentstring=\"\ %s
  autocmd FileType gitcommit,markdown       setlocal spell
  autocmd FileType scheme                   setlocal lisp
  autocmd BufNewfile,BufReadPost *.md set filetype=markdown
  autocmd BufNewfile,BufReadPost *.pl set filetype=prolog
augroup END

augroup InsertEvents
  autocmd!
  autocmd InsertLeave * set iminsert=0
  autocmd InsertEnter * set nolist
  autocmd InsertLeave * set list
augroup END

" }}}

let s:local_vimrc = $HOME . '/.vimrc-local'
if filereadable(s:local_vimrc)
  execute 'source' s:local_vimrc
endif

set nocursorcolumn
