" Vimrc and gVimrc file

"==== System Information ===="
if has('win32') || has('win16')
  let s:os = 'windows'
elseif has('unix')
  let s:os = substitute(system('uname'), '\n', '', '')
else
  let s:os = 'undefined'
endif

let g:mapleader = ','

set nocompatible             " be iMproved!
set nobackup                 " no annoying file.txt~ files
set modelines=0              " Security reasons
set autochdir
set showcmd
set ttimeoutlen=200          " Exit insert mode quickly
set timeoutlen=1000          " But still give me time to enter leader commands
set scrolloff=4              " keep at least 4 lines above/below
set sidescrolloff=4          " keep at least 4 lines left/right
set textwidth=80
set autoindent
set smartindent
set splitbelow
set virtualedit=block        " makes virtual blocks cleaner and blockier
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj
set lazyredraw
set ruler
set number numberwidth=1
set backspace=indent,eol,start
set hlsearch                 " highlights search results
set incsearch                " searches as you type
set ignorecase smartcase     " case insensitive for all-lower searches
set t_Co=256
set t_ut=
colorscheme fischer_dark
syntax on
nohl                         " Default = don't highlight


"==== Vundle ===="
filetype off
if s:os ==# 'windows'
  set rtp+=~/vimfiles/bundle/Vundle.vim/
else
  set rtp+=~/.vim/bundle/Vundle.vim/
endif

call vundle#begin()
" Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'google/vim-maktaba'
Plugin 'nfischer/vim-marker', {'pinned': 1}
Plugin 'nfischer/vim-vimignore'
Plugin 'rgrinberg/vim-ocaml'
Plugin 'scrooloose/syntastic'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'wlangstroth/vim-racket'
" Plugin 'airblade/vim-gitgutter'
" Plugin 'ap/vim-buftabline'
" Plugin 'bpowell/vim-android'
" Plugin 'hsanson/vim-android'
" Plugin 'syngan/vim-vimlint'
call vundle#end()

" Airline settings
set laststatus=2

" PatienceDiff settings
let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'

" Built-in plugins
runtime ftplugin/man.vim
filetype plugin on

" Fugitive settings
augroup FileTypeOptions
  " Configure comment patterns and other things
  autocmd!
  autocmd FileType c,cpp,cs,java,markdown   setlocal commentstring=//\ %s
  autocmd FileType bash,python              setlocal commentstring=#\ %s
  autocmd FileType vim                      setlocal commentstring=\"\ %s
  autocmd FileType gitcommit,markdown       setlocal spell
  autocmd FileType scheme                   setlocal lisp
augroup END
nnoremap <silent> <leader>gs :<C-u>Gstatus<CR>
nnoremap <silent> <leader>ga :<C-u>Gwrite<CR>
nnoremap <silent> <leader>gc :<C-u>Gcommit<CR>
nnoremap <silent> <leader>gp :<C-u>Gpush<CR>
nnoremap <silent> <leader>gd :<C-u>Gdiff<CR>
nnoremap <silent> <leader>gb :<C-u>Gblame<CR>
nnoremap <silent> <leader>gi :<C-u>GEditIgnore<CR>
set diffopt=vertical

" Vundle mappings
nnoremap <silent> <leader>vu :<C-u>PluginInstall!<CR>
nnoremap <silent> <leader>vi :<C-u>PluginInstall<CR>
nnoremap <silent> <leader>vl :<C-u>PluginList<CR>

" Tmux mappings
nnoremap <silent> <Left>    :TmuxNavigateLeft<cr>
nnoremap <silent> <Down>    :TmuxNavigateDown<cr>
nnoremap <silent> <Up>      :TmuxNavigateUp<cr>
nnoremap <silent> <Right>   :TmuxNavigateRight<cr>

" Syntastic settings
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_always_populate_loc_list = 1
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

"==== Indentation and word wrapping ===="
if !exists('s:has_set_indent')
  set shiftwidth=2 tabstop=2 softtabstop=2
  set expandtab
  set smarttab
  let s:has_set_indent = 1
endif

" Format options to wordwrap properly, but not auto-comment
"set lbr
if v:version < 704
  set formatoptions=qnl      " Add the options I want
else
  set formatoptions=qnlj
endif
" Autocommenting is removed by a plugin

" Configure the mouse (scrolling only)
set mouse=a
noremap  <LeftMouse>   <nop>
noremap  <LeftRelease> <nop>
noremap  <RightMouse>  <nop>
inoremap <LeftMouse>   <nop>
inoremap <LeftRelease> <nop>
inoremap <RightMouse>  <nop>

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

" Set up markdown highlighting
augroup Markdown
  autocmd!
  autocmd BufNewfile,BufReadPost *.md set filetype=markdown
  autocmd BufNewfile,BufReadPost *.pl set filetype=prolog
augroup END

if has('gui_running')
  " GUI specific
  set visualbell
  set t_vb=
  set guioptions=T

  " Select columns better with gg & G in visual mode
  " Note: set nosol interferes with DRAG_VISUALS in console vim
  set nosol
  nnoremap <silent> <C-v> :set nosol<CR><C-v>
  vnoremap <silent> <ESC> <ESC>:set sol<CR>
endif

if s:os ==# 'windows'
  set dir=%TMP%
else
  set dir=~/.vim/tmp,.
endif

"==== Capslock ===="
" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
  exe 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  exe 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor

augroup InsertEvents
  autocmd!
  autocmd InsertLeave * set iminsert=0
  autocmd InsertEnter * set nolist
  autocmd InsertLeave * set list
augroup END

"==== Alt key ===="

set winaltkeys=no

"==== Key mappings ===="

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

"==== Instantly Better Vim additions ===="

"====[ Make the 81st column stand out ]===="
hi ColorColumn  gui=bold guifg=black guibg=magenta cterm=bold ctermfg=black
   \ ctermbg=magenta
augroup HilightColumn
  autocmd!
  autocmd BufEnter,WinEnter * call matchadd('ColorColumn', '\%81v', 100)
augroup END

"====[ Highlight matches when jumping to next ]===="
nnoremap <silent> n   n:call HLNext(0.15)<CR>
nnoremap <silent> N   N:call HLNext(0.15)<CR>
nnoremap <silent> '   :call HLGoto(0.15)<CR>
nnoremap ` '

function! Blink(blinks, blinktime, blinkcmd, unblinkcmd)
  let l:sleep_cmd =  'sleep ' . float2nr(a:blinktime * 1000 / a:blinks) . 'm'
  for n in range(1, a:blinks)
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
  for n in range(1,l:blinks)
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
    echohl ErrorMsg | echo l:msg | echohl none
    return
  endtry
  " Blink
  let s:oldcursorline=&cursorline
  set nocursorline
  call Blink(4, a:blinktime, 'set cursorline!', 'set cursorline!')
  " Restore cursorline setting
  let &cursorline=s:oldcursorline
endfunction

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
  for i in range(a:number_of_times)
    exe l:command
  endfor
  let l:result = localtime() - l:start_time
  let &more = l:old_more
  return l:result
endfunction

"==== Leader functions ===="

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
  silent exe a:firstline . ',' . a:lastline . 's/\C\<' . a:orig . '\>/' . a:new
      \ . '/g'
  echo a:orig . ' -> ' . a:new
  call setreg('/', l:old_search)
endfunction

" a:orig is the original indent, and a:new is the preferred new indent
function! ChangeIndentFunc(orig, new)
  let l:old_et = &et
  exe 'set ts=' . a:orig . ' sts=' . a:orig . ' noet'
  retab!
  exe 'set ts=' . a:new . ' sts=' . a:new . ' sw=' . a:new
  if (l:old_et)
    set et
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
      for e in l:executables
        if bufexists(e) || empty(l:runtarget)
          let l:runtarget = e
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
    call system('chmod 755 ' . l:fnames)
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
    echo l:msg_string " In vim if we have more buffers
  endif
endfunction

function! NumberOfBuffers()
  let l:highest = bufnr('$')
  let l:bufcount = 0
  for i in range(1, l:highest+1)
    if buflisted(i)
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
  for f in a:000
    echo f
    " asynchronously open f
    call system(s:open_cmd . ' ' . f . '&>/dev/null &')
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
    for f in a:000
      call WC_file(f)
      echon '   ' . f
      echo ''
    endfor
  endif
endfunction

"==== Leader mappings ===="

nnoremap          <leader>bu :b<Space>
nnoremap          <leader>rf :RenameToken <C-r><C-w><space>
vnoremap          <leader>rf :RenameToken<space>
nnoremap          <leader>st :SyntasticToggleMode<CR>
nnoremap          <leader>sc :SyntasticCheck<CR>
nnoremap          <leader>vg :vimgrep<Space><C-r><C-W><Space>*<CR>
nnoremap <silent> <leader>qf :<C-u>cwindow<CR>
nnoremap <silent> <leader>C  :let &scrolloff=999-&scrolloff<CR>
noremap  <silent> <leader>ev :<C-u>call EditConfigFile($MYVIMRC)<CR>
noremap  <silent> <leader>eb :<C-u>call EditConfigFile(expand('~/.bashrc'))<CR>
noremap  <silent> <leader>et :<C-u>call
    \ EditConfigFile(expand('~/.tmux.conf'))<CR>
noremap  <silent> <leader>sv :<C-u>source $MYVIMRC<CR>
noremap  <silent> <leader>eh :<C-u>exe 'vsp ' . expand('<cfile>')<CR>
map      <silent> <leader>ef <leader>eh
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

"==== Custom Commands ===="

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
com! -nargs=* -complete=file          Ls echo system('ls --color=auto <f-args>')
com! -nargs=* -complete=file          Wc call WordCount(<f-args>)

"====[ Open any file with a pre-existing swapfile in readonly mode ]===="
augroup NoSimultaneousEdits
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
  autocmd SwapExists * echohl ErrorMsg
  autocmd SwapExists * echomsg 'Duplicate edit session (readonly)'
  autocmd SwapExists * echohl NONE
  autocmd SwapExists * sleep 1
augroup END

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

"==== Make tabs, trailing whitespace, and non-breaking spaces visible, but not in insert mode ===="

exe "set listchars=tab:\uB6~,trail:\uB7,nbsp:~"
set list

"==== Make visual blocks a little prettier and more useful ===="

"==== Vim Window setup ===="

nnoremap <silent> <C-w>h :call MoveSplit('left')<CR>
nnoremap <silent> <C-w>l :call MoveSplit('right')<CR>

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

" Move a single char left or right
nmap  <expr>  <C-LEFT>   MoveChar('left')
nmap  <expr>  <C-RIGHT>  MoveChar('right')

"==== Reload vimrc whenever it's saved ===="
augroup ConfigReload
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

set nocursorcolumn
