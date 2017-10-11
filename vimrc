" vim: set foldmethod=marker foldlevel=0:
" Vimrc and gVimrc file

let g:mapleader = ','
let s:local_vimrc = $HOME . '/.vimrc.local'

" ===============================================================
" System Information {{{
" ===============================================================

if has('win32') || has('win16')
  let s:os = 'windows'
  let s:VIMFILES = $HOME . '/vimfiles'
elseif has('unix')
  let s:os = 'unix'
  let s:VIMFILES = $HOME . '/.vim'
else
  let s:os = 'undefined'
  let s:VIMFILES = $HOME . '/.vim'
endif

" }}}
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
set guioptions=T
set hidden                  " Buffers finally don't suck
set history=10000
set hlsearch                " highlights search results
set ignorecase smartcase    " case insensitive for all-lower searches
set incsearch               " searches as you type
set lazyredraw
set list
set matchpairs+=<:>
set modelines=0             " Security reasons
set mouse=a
set nobackup                " no annoying file.txt~ files
set noerrorbells
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
set t_vb=
set textwidth=80
set timeoutlen=1000         " But still give me time to enter leader commands
set ttimeoutlen=200         " Exit insert mode quickly
set undofile                " Preserve undo history between sessions
set undolevels=1000
set virtualedit=block       " makes virtual blocks cleaner and blockier
set visualbell
set wildignore+=.DS_Store,*.swp,*.bak,*.pyc,*.class,*.o,*.obj
set winaltkeys=no           " Don't let Windows eat the alt-key

if exists('+inccommand')
  set inccommand=nosplit
endif

" }}}
" ===============================================================
" vim-plug {{{
" ===============================================================

" Built-in plugins
runtime ftplugin/man.vim

function! Cond(cond, ...)
  let l:opts = get(a:000, 0, {})
  return a:cond ? l:opts : extend(l:opts, { 'on': [], 'for': [] })
endfunction

let g:has_python = (has('python') || has('python3'))

let g:plug_window = 'enew'

call plug#begin(s:VIMFILES . '/plugged')

Plug 'SirVer/ultisnips',        Cond(g:has_python && v:version >= 704)
Plug 'Valloric/MatchTagAlways', Cond(g:has_python)
Plug 'google/vim-codereview',   Cond(g:has_python)
Plug 'google/vim-glaive',       Cond(g:has_python)
Plug 'google/vim-maktaba',      Cond(g:has_python)

Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })
Plug 'Shougo/neocomplete.vim', Cond(!has('nvim'))

Plug 'chrisbra/vim-diff-enhanced', Cond(v:version >= 704)
Plug 'jlanzarotta/bufexplorer', Cond(v:version >= 704)

Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dag/vim-fish'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'hail2u/vim-css3-syntax'
Plug 'honza/vim-snippets'
Plug 'idanarye/vim-merginal'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'luochen1990/rainbow'
Plug 'mattn/webapi-vim'
Plug 'mileszs/ack.vim'
Plug 'miyakogi/conoline.vim'
Plug 'moll/vim-node'
Plug 'neomake/neomake' | let s:neomake_loaded = 1
Plug 'nfischer/vim-ohm'
Plug 'nfischer/vim-potigol'
Plug 'nfischer/vim-rainbows'
Plug 'nfischer/vim-vimignore'
Plug 'pangloss/vim-javascript'
Plug 'rgrinberg/vim-ocaml'
Plug 'rhysd/nyaovim-markdown-preview'
Plug 'rhysd/nyaovim-popup-tooltip'
Plug 'rhysd/nyaovim-running-gopher'
Plug 'rhysd/vim-crystal'
Plug 'rhysd/vim-gfm-syntax'
Plug 'snaewe/Instantly_Better_Vim_2013'
Plug 'suy/vim-context-commentstring'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tyrannicaltoucan/vim-quantum' | let s:quantum_loaded = 1
Plug 'vim-airline/vim-airline' | let s:airline_loaded = 1
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/tmux-complete.vim'
Plug 'whatyouhide/vim-lengthmatters'

" Plug 'bogado/file-line'
" Plug 'roryokane/detectindent' | let s:detect_indent_loaded = 1
" Plug 'wlangstroth/vim-racket'

call plug#end()

" }}}
" ===============================================================
" Plugin settings {{{
" ===============================================================

" Tmux stuff
let g:tmux_navigator_disable_when_zoomed = 1

" vim-crystal
let g:crystal_define_mappings = 0 " Don't interfere with commentary

" vim-slash
nnoremap <plug>(slash-after) zz

" Easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Syntax highlighting and colorscheme
if has('termguicolors')
  " Must enable true color on vim8, because it's dumb...
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if exists('s:quantum_loaded')
  let g:airline_theme = 'quantum'
  let g:quantum_black = 1
  colorscheme quantum
endif
syntax on

let g:conoline_use_colorscheme_default_normal = 1
let g:conoline_use_colorscheme_default_insert = 1

if executable('ag')
  let g:ackprg = 'ag --smart-case'
endif

highlight GitGutterAdd    cterm=bold ctermfg=green
highlight GitGutterChange cterm=bold ctermfg=grey
highlight GitGutterDelete cterm=bold ctermfg=red

highlight MatchParen cterm=bold ctermfg=lightblue ctermbg=NONE
      \ gui=bold guifg=#63c9d6 guibg=NONE

let g:deoplete#enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1

let g:neomake_javascript_enabled_makers = ['eslint']

if has('nvim') || has('job')
  if exists('s:neomake_loaded')
    augroup Neomake
      au!
      au BufEnter,BufWritePost * Neomake
    augroup END
  endif
endif

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

" Airline settings
set laststatus=2

" PatienceDiff settings
if v:version >= 704
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

" DetectIndent settings
if exists('s:detect_indent_loaded')
  augroup DetectIndent
    autocmd!
    autocmd BufReadPost * DetectIndent
  augroup END
endif

" Fugitive settings
nnoremap          <leader>gdm :<C-u>Gdiff master<CR>
nnoremap          <leader>gh  :<C-u>Gdiff HEAD~
nnoremap <silent> <leader>gH  :<C-u>Gdiff HEAD<CR>
nnoremap <silent> <leader>ga  :<C-u>Gwrite<CR>
nnoremap <silent> <leader>gb  :<C-u>Gblame<CR>
nnoremap <silent> <leader>gc  :<C-u>Gcommit<CR>
nnoremap <silent> <leader>gd  :<C-u>Gdiff<CR>
nnoremap <silent> <leader>gh1 :<C-u>Gdiff HEAD~1<CR>
nnoremap <silent> <leader>ghh :<C-u>Gdiff HEAD<CR>
nnoremap <silent> <leader>gi  :<C-u>GEditIgnore<CR>
nnoremap <silent> <leader>gps :<C-u>Gpush<CR>
nnoremap <silent> <leader>gs  :<C-u>Gstatus<CR>

" Vim-plug mappings
nnoremap <silent> <leader>vu :<C-u>PlugUpdate<CR>
nnoremap <silent> <leader>vi :<C-u>PlugInstall<CR>

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

" Configure the mouse (scrolling only)
noremap  <LeftMouse>   <nop>
noremap  <LeftRelease> <nop>
noremap  <RightMouse>  <nop>
inoremap <LeftMouse>   <nop>
inoremap <LeftRelease> <nop>
inoremap <RightMouse>  <nop>

" }}}
" ===============================================================
" 'directory' and 'undodir' {{{
" ===============================================================

let s:prefix = s:os ==# 'windows' ? '%TMP%\' : '~/.vim/'
function! s:SetAndMake(var_name, location)
  exe 'set ' . a:var_name . '=' . s:prefix . a:location . ',.'
  silent! call mkdir(expand(s:prefix . a:location), 'p')
endfunction
call s:SetAndMake('directory', 'tmp')
call s:SetAndMake('undodir', 'undodir')

" }}}
" ===============================================================
" Key mappings {{{
" ===============================================================

noremap  ;  :
noremap  <Bslash>  ;

" Force tmux to respect <C-a>
cnoremap  <C-a> <home>

" Prevents annoying behavior
nnoremap          Q     <nop>
nnoremap <silent> K     k:echoerr 'CAPSLOCK IS ON'<CR>
nnoremap <silent> J     j:echoerr 'CAPSLOCK IS ON'<CR>
vnoremap <silent> K     k:<C-u>echoerr 'CAPSLOCK IS ON'<CR>gv
vnoremap <silent> J     j:<C-u>echoerr 'CAPSLOCK IS ON'<CR>gv
cnoremap          q~    q!
cnoremap          q1    q!

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

"====[ Highlight jumps to marks ]===="
nnoremap <silent> '   :call HLGoto(0.15)<CR>
nnoremap ` '

function! s:Blink(blinks, blinktime, blinkcmd, unblinkcmd)
  let l:sleep_cmd =  'sleep ' . float2nr(a:blinktime * 1000 / a:blinks) . 'm'
  for l:n in range(1, a:blinks)
    exe a:blinkcmd | redraw | exe l:sleep_cmd
    exe a:unblinkcmd | redraw | exe l:sleep_cmd
  endfor
endfunction

function! HLGoto(blinktime)
  try
    let l:c = nr2char( getchar() )
    exe 'normal! `' . l:c
  catch /.*/
    let l:msg = substitute(v:exception, '\m\C^Vim(.*):\(.*\)$', '\1', '')
    echohl ErrorMsg | echo l:msg | echohl NONE
    return
  endtry
  let s:oldcursorline=&cursorline
  set nocursorline
  call s:Blink(4, a:blinktime, 'set cursorline!', 'set cursorline!')
  " Restore cursorline setting
  let &cursorline=s:oldcursorline
endfunction

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

function! s:RenameTokenFunction(orig, new) range
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
" vint: +ProhibitCommandWithUnintendedSideEffect
" vint: +ProhibitCommandRelyOnUser

function! s:AddTodo(msg)
  let l:todo_str = 'TODO(' . $USER . '): ' . a:msg
  if &commentstring !~# '\v^.+ \%s'
    let l:todo_str = ' ' . l:todo_str
  endif
  let l:full_text = substitute(&commentstring, '%s', l:todo_str, '')
  let l:line_text = getline('.')
  let l:indent = matchstr(l:line_text, '^\s*')
  put!=l:indent . l:full_text
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

function! s:SudoWriteFile()
  " This will write a file that is read-only, using sudo permission
  silent write !sudo tee % >/dev/null
endfunction

function! s:OpenFunction(...)
  for l:f in a:000
    call netrw#BrowseX(l:f, netrw#CheckIfRemote())
  endfor
endfunction

function! s:WcFile(...)
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

function! s:WordCount(...)
  if a:0 == 0
    call s:WcFile() " No parameter
  else
    for l:f in a:000
      call s:WcFile(l:f)
      echon '   ' . l:f
      echo ''
    endfor
  endif
endfunction

" }}}
" ===============================================================
" Leader mappings {{{
" ===============================================================

nnoremap          <leader>sq ciwsquash<Esc>b
nnoremap          <leader>rf :RenameToken <C-r><C-w><space>
vnoremap          <leader>rf :RenameToken<space>
nnoremap <silent> <leader>C  :let &scrolloff=999-&scrolloff<CR>
noremap  <silent> <leader>ev :<C-u>call EditConfigFile($MYVIMRC)<CR>
noremap  <silent> <leader>ea :<C-u>call
    \ EditConfigFile(expand('~/.shell_aliases'))<CR>
noremap  <silent> <leader>eb :<C-u>call EditConfigFile(expand('~/.bashrc'))<CR>
noremap  <silent> <leader>ez :<C-u>call EditConfigFile(expand('~/.zshrc'))<CR>
noremap  <silent> <leader>eV :<C-u>call EditConfigFile(s:local_vimrc)<CR>
noremap  <silent> <leader>eB :<C-u>call EditConfigFile(expand('~/.bashrc.local'))<CR>
noremap  <silent> <leader>eZ :<C-u>call EditConfigFile(expand('~/.zshrc.local'))<CR>
noremap  <silent> <leader>et :<C-u>call
    \ EditConfigFile(expand('~/.tmux.conf'))<CR>

nnoremap <silent> <leader>f  :echo expand('%')<CR>
nnoremap <silent> <leader>w  :<C-u>silent call FixWhiteSpace()<CR>

nnoremap          <leader>2  A >&2<ESC>

" }}}
" ===============================================================
" Custom Commands {{{
" ===============================================================

command! -complete=file -nargs=1         Browser !x-www-browser <args> &>/dev/null &
command! -nargs=0                        Yank normal! ggVG"+y``
command! -nargs=0                        Blast normal! ggVG"+p

command! -nargs=0                        LongLines call setreg('/', '\m^.\{81,}$')|
    \ echo 'press n to go to the next long line'
command! -nargs=1                        Todo call s:AddTodo(<q-args>)
command! -nargs=+ -complete=command      Profile echo HowLong(<f-args>)

"  TODO(nate): Move this into a separate plugin
command! -nargs=* -complete=var -range=% RenameToken <line1>,<line2>
    \ call s:RenameTokenFunction(<f-args>)

" Enable saving read-only files using sudo
command! -nargs=0                        W call s:SudoWriteFile()

" Unixy things (that eunuch.vim missed)
command! -nargs=+ -complete=file         Open call s:OpenFunction(<f-args>)
command! -nargs=* -complete=file         Ls echo system('ls --color=auto ' . <q-args>)
command! -nargs=* -complete=file         Wc call s:WordCount(<f-args>)

" }}}
" ===============================================================
" Autocommands {{{
" ===============================================================

" Highlight VCS conflict markers
augroup GitConflictMarkers
  autocmd!
  autocmd WinEnter,BufEnter * call matchadd('ErrorMsg','\v^\={7}$', 99)
  autocmd WinEnter,BufEnter * call matchadd('ErrorMsg','\v^(\<{7}|\>{7})\s.*$', 99)
augroup END

"==== JumpCursorOnEdit ===="

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

"==== Reload vimrc whenever it's saved ===="
augroup ConfigReload
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
  if exists('s:airline_loaded')
    autocmd BufWritePost $MYVIMRC AirlineRefresh
  endif
augroup END

"==== No damn blinking lights! ===="
augroup ErrorBells
  autocmd!
  autocmd GUIEnter * set vb t_vb=
augroup END

" This is also handled in the Instantly_Better_Vim_2013 plugin
augroup NoSimultaneousEdits
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
augroup END

augroup FileTypeOptions
  " Configure comment patterns and other things
  autocmd!
  autocmd FileType c,cpp,cs,java,markdown   setlocal commentstring=//\ %s
  autocmd FileType bash,python              setlocal commentstring=#\ %s
  autocmd FileType vim                      setlocal commentstring=\"\ %s
  autocmd FileType gitcommit,markdown       setlocal spell
  autocmd FileType gitcommit normal! gg
  autocmd FileType scheme                   setlocal lisp
  autocmd BufNewfile,BufReadPost *.md set filetype=markdown
  autocmd BufNewfile,BufReadPost *.pl set filetype=prolog
  autocmd BufNewfile,BufReadPost *.zshrc,*.zsh-theme set filetype=zsh
  autocmd BufNewfile,BufReadPost *.bashrc set filetype=sh
augroup END

augroup InsertEvents
  autocmd!
  autocmd InsertLeave * set iminsert=0
  autocmd InsertEnter * set nolist
  autocmd InsertLeave * set list
augroup END

" }}}
" ===============================================================
" Miscellaneous {{{
" ===============================================================

"==== Make whitespace visible, but not in insert mode ===="

" vint: -ProhibitUnnecessaryDoubleQuote
exe "set listchars=tab:\uB6~,trail:\uB7,nbsp:~"
" vint: +ProhibitUnnecessaryDoubleQuote

"==== Vim Window setup ===="
nnoremap <silent> <C-w>h :call MoveSplit('left')<CR>
nnoremap <silent> <C-w>l :call MoveSplit('right')<CR>

" }}}
" ============================================================================
" After {{{
" ============================================================================

" These settings need to be reset near the end of the vimrc
set nocursorcolumn
nohlsearch

" }}}
" ============================================================================
" Local vimrc {{{
" ============================================================================

if filereadable(s:local_vimrc)
  execute 'source' . s:local_vimrc
endif

" }}}
" ============================================================================
