" Vimrc and gVimrc file

"==== System Information ===="
if has('win32') || has('win16')
  let g:os = 'windows'
elseif has('unix')
  let g:os = substitute(system('uname'), '\n', '', '')
  " set shellcmdflag=-ic      " Improve the shell!
else
  let g:os = 'undefined'
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

"==== Vundle ===="
filetype off
if g:os ==# 'windows'
  set rtp+=~/vimfiles/bundle/Vundle.vim/
else
  set rtp+=~/.vim/bundle/Vundle.vim/
endif

call vundle#begin()
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'google/vim-maktaba'
Plugin 'nfischer/Vundle.vim'
Plugin 'nfischer/vim-vimignore'
Plugin 'rgrinberg/vim-ocaml'
Plugin 'scrooloose/syntastic'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'chrisbra/vim-diff-enhanced'
" Plugin 'airblade/vim-gitgutter'
" Plugin 'ap/vim-buftabline'
" Plugin 'bpowell/vim-android'
" Plugin 'hsanson/vim-android'
" Plugin 'syngan/vim-vimlint'
call vundle#end()

" SyntasticToggleMode
let g:syntastic_mode_map = { 'mode': 'passive' }

" For Airline
set laststatus=2

" For PatienceDiff
let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'

" Built-in plugins
runtime ftplugin/man.vim
filetype plugin on

" Configure comment patterns and other things
augroup FTOptions
  autocmd!
  autocmd FileType c,cpp,cs,java,markdown   setlocal commentstring=//\ %s
  autocmd FileType bash,python              setlocal commentstring=#\ %s
  autocmd FileType vim                      setlocal commentstring=\"\ %s
  autocmd FileType gitcommit                setlocal spell
  autocmd FileType bash,sh,zsh,csh,tcsh
      \ inoremap <silent> <buffer> <C-X>! #!/bin/<C-R>=&ft<CR>
augroup END

" Fugitive mappings
nmap <silent> <leader>gs :<C-u>Gstatus<CR>
nmap <silent> <leader>ga :<C-u>Gwrite<CR>
nmap <silent> <leader>gc :<C-u>Gcommit<CR>
nmap <silent> <leader>gp :<C-u>Gpush<CR>
nmap <silent> <leader>gd :<C-u>Gdiff<CR>
nmap <silent> <leader>gi :<C-u>GEditIgnore<CR>
set diffopt=vertical

" Vundle mappings
nmap <silent> <leader>vu :<C-u>PluginInstall!<CR>
nmap <silent> <leader>vi :<C-u>PluginInstall<CR>
nmap <silent> <leader>vl :<C-u>PluginList<CR>

" Tmux mappings
nnoremap <silent> <A-Left>  :TmuxNavigateLeft<cr>
nnoremap <silent> <A-Down>  :TmuxNavigateDown<cr>
nnoremap <silent> <A-Up>    :TmuxNavigateUp<cr>
nnoremap <silent> <A-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <Left>    :TmuxNavigateLeft<cr>
nnoremap <silent> <Down>    :TmuxNavigateDown<cr>
nnoremap <silent> <Up>      :TmuxNavigateUp<cr>
nnoremap <silent> <Right>   :TmuxNavigateRight<cr>

" Syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

"==== Indentation and word wrapping ===="
if !exists('g:has_set_indent')
  set shiftwidth=2 tabstop=2 softtabstop=2
  set expandtab
  set smarttab
  let g:has_set_indent = 1
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
augroup END

"==== Syntax highlighting and coloring ===="
set t_Co=256
set t_ut=
set background=dark
syntax on
hi Cursorline gui=NONE    cterm=NONE                ctermbg=darkgrey
hi Normal     guifg=white guibg=black ctermfg=white
hi Search     guifg=black guibg=cyan  ctermfg=black ctermbg=cyan
hi SpellBad   guifg=black guibg=red   ctermfg=black ctermbg=red
hi SpellCap   guifg=white guibg=blue  ctermfg=white ctermbg=blue
hi VertSplit  guifg=darkgrey guibg=NONE ctermfg=darkgrey ctermbg=NONE
   \ cterm=bold gui=bold

"==== Searching ===="
set hlsearch                 " highlights search results
nohl                         " Default = don't highlight
set incsearch                " searches as you type
set ignorecase smartcase     " case insens for all-lower searches

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

if g:os ==# 'windows'
  set dir=%TMP%              " Hide .swp files away on windows
else
  set dir=~/.vim/tmp,.
endif

"==== Capslock ===="
" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
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

cnoremap  q~  q!
cnoremap  q1  q!

" Force tmux to respect <C-a>
cnoremap  <C-a> <home>

" Prevent annoying ex mode
nnoremap Q <nop>

" Help with quickfix (also leader mappings)
nnoremap <silent> cn :cnext<CR>
nnoremap <silent> cp :cprevious<CR>

" prevents annoying behavior
nnoremap  <silent> K  k:echoerr 'CAPSLOCK IS ON'<CR>
nnoremap  <silent> J  j:echoerr 'CAPSLOCK IS ON'<CR>
vnoremap  <silent> K  k:<C-u>echoerr 'CAPSLOCK IS ON'<CR>gv
vnoremap  <silent> J  j:<C-u>echoerr 'CAPSLOCK IS ON'<CR>gv

" Treat long lines as break lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" This is a tmux workaround to allow me to redraw the screen with
" <prefix-key><C-l>
nnoremap <silent> <C-o> :<C-u>nohl<CR><C-l>

" <C-a> highlights all, + will increment numbers
nnoremap + <C-a>
nnoremap <C-a> ggVG

" Adjust yanking to be more consistent with other conventions
nnoremap Y y$

" Spell checking
if exists('+spelllang')
  set spelllang=en_us
endif
nmap <silent> <leader>sp :setlocal spell!\|set spell?<CR>
vmap <silent> <leader>sp :<C-u>setlocal spell!<CR>gv
imap <C-l> <Esc>[s1z=`]a

"==== Instantly Better Vim additions ===="

"====[ Make the 81st column stand out ]===="

" OR ELSE just the 81st column of wide lines
hi ColorColumn  gui=bold guifg=black guibg=magenta cterm=bold ctermfg=black
   \ ctermbg=magenta
augroup HilightColumn
  autocmd!
  autocmd BufEnter,WinEnter * call matchadd('ColorColumn', '\%81v', 100)
  " autocmd BufEnter,WinEnter *.java call matchadd('ColorColumn', '\%101v', 100)
augroup END

"====[ Highlight matches when jumping to next ]===="

" This rewires n and N to do the highlighting
let g:n_time  = 0.15
let g:gt_time = 0.15
nnoremap <silent> n   n:call HLNext(g:n_time)<CR>
nnoremap <silent> N   N:call HLNext(g:n_time)<CR>
nnoremap <silent> '   :call HLGoto(g:gt_time)<CR>
nnoremap ` '

" OR ELSE just highlight the match in red
hi WhiteOnRed guifg=white guibg=red ctermfg=white ctermbg=red
function! HLNext (blinktime)
  let [l:bufnum, l:lnum, l:col, l:off] = getpos('.')
  let l:matchlen = strlen(matchstr(strpart(getline('.'),l:col-1),@/))
  let l:target_pat = '\c\%#'.@/
  let l:blinks = 4
  let l:sleep_cmd =  'sleep ' . float2nr((a:blinktime / l:blinks) * 1000) . 'm'
  for n in range(1,l:blinks)
    let l:ring = matchadd('WhiteOnRed', l:target_pat, 101)
    redraw
    exe l:sleep_cmd
    call matchdelete(l:ring)
    redraw
    exe l:sleep_cmd
  endfor
endfunction

function! HLGoto (blinktime)
  try
    let l:c = nr2char( getchar() )
    exe 'normal! `' . l:c
  catch
    echohl ErrorMsg | echo 'E20: Mark not set' | echohl none
    return
  endtry
  let l:blinks = 4
  let s:oldcursorline=&cursorline
  set nocursorline
  let l:sleep_cmd = 'sleep ' . float2nr(a:blinktime / (l:blinks) * 1000) . 'm'
  for n in range(0,l:blinks)
    set cursorline!
    redraw
    exe l:sleep_cmd
  endfor
  " Restore cursorline setting
  let &cursorline=s:oldcursorline
endfunction

function! MoveChar(dir)
  if (a:dir ==# 'left' && col('.') == 1) || (col('.') == col('$')-1 && a:dir !=# 'left')
    return ''
  elseif (a:dir ==# 'left')
    if (col('.') == col('$')-1)
      return 'xP'
    else
      return 'xhP'
    endif
  else
    return 'xp'
  endif
endfunction

" Times the number of times a particular command takes to execute the specified number of times (in seconds).
function! HowLong(number_of_times, ...)
  " We don't want to be prompted by a message if the command being tried is
  " an echo as that would slow things down while waiting for user input.
  let l:command = join(a:000)
  echo 'Running "' . l:command . '" ' . a:number_of_times . ' times'

  let l:old_more = &more
  set nomore
  let l:start_time = localtime()
  for i in range(a:number_of_times)
    execute l:command
  endfor
  let l:result = localtime() - l:start_time
  let &more = l:old_more
  return l:result
endfunction

command! -nargs=+ -complete=command Profile echo HowLong(<f-args>)

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

function! MdToPdf()
  " Test for pandoc
  let l:pandoc_path = system('which pandoc 2>/dev/null')
  let l:md_name = expand('%')
  if empty(l:pandoc_path)
    " Pandoc isn't installed
    echohl ErrorMsg
    echomsg 'Pandoc is not installed. Unable to create pdf'
    echohl None
  elseif empty(l:md_name)
    echohl ErrorMsg
    echomsg "You aren't writing a saved file!"
    echohl None
  else
    " Create pdf
    let l:pdf_name = expand('%:r') . '.pdf'
    let l:p_cmd = 'pandoc ' . l:md_name . ' -o ' . l:pdf_name
    let l:output = system(l:p_cmd)
    if empty(l:output)
      let l:cmd = 'xdg-open ' . l:pdf_name . ' >/dev/null 2>&1 &'
      call system(l:cmd)
    else
      " We got an error of some sort
      echohl WarningMsg | echomsg output | echohl None
    endif
  endif
endfunction

function! DrawBox()
  normal! yy2p
  s/+/\|/eg
  s/-/ /eg
  nohl
endfunction

function! Underline(myVar)
  let l:lineNumber = line('.')
  let l:nextLine = getline(l:lineNumber + 1)
  " Test if nextLine is an underline
  let l:isUnderline = 0 " not ready yet

  " Delete the line if it's an underline
  if l:isUnderline == 1
    normal! jddk
  endif

  " Insert new line composed of myVar
  if a:myVar == '='
    normal! yypVr=
    return
  else
    normal! yypVr-
    return
  endif
endfunction

" TODO: Make a Todo command (use value of commentstring setting)
function! AddTodo(msg)
  let l:todo_string = substitute(&commentstring, '%s', 'TODO(' . $USER . '): ' . a:msg, '')
  let l:line_text = getline('.')
  let l:indent = matchstr(l:line_text, '^\s*')
  put!=l:indent . l:todo_string
endfunction

" TODO: Clean this up
function! RunProject()
  " Try to see if the current file is executable
  let l:runtarget = system('find ' . expand('%:p') . ' -type f -executable -print')
  if empty(l:runtarget)
    " Search all open buffers for an executable file
    let l:executables = split(system('find * -type f -executable -print'), '\n')
    for e in l:executables
      if bufexists(e) || empty(l:runtarget)
        let l:runtarget = e
      endif
    endfor
  endif
  if empty(l:runtarget)
    echohl ErrorMsg
    echomsg 'Error: could not find a runtarget'
    echohl NONE
  else
    let l:full_path = fnamemodify(l:runtarget, ':p')
    exec 'silent !echo ' . l:full_path
    exec '!' . l:full_path
  endif
endfunction

let g:warnedForFile = 0

"==== Edit .vimrc quickly ===="
function! EditConfigFile(configName, ...)
  if !filewritable(a:configName)
    echohl ErrorMsg
    echo a:configName . ' can't be edited'
    echohl NONE
  else
    let l:fname = expand('%:p')
    if line('$') == 1 && getline(1) == '' && empty(l:fname)
      " We're not editing anything interesting, so open in a full window
      exe 'edit ' . a:configName
    elseif l:fname ==# a:configName && g:warnedForFile == 0
      echo 'Already editing ' . expand('%:t') . '. Try again to open'
      let g:warnedForFile = 1
    else
      exe 'vsp ' . a:configName
    endif
    " Configure this buffer
    if !exists('a:1')
      set bufhidden=delete
    endif
  endif
endfunction

function! MakeExecutable(...)
  if has('unix')
    if len(a:000) == 0
      let l:oldautoread = &l:autoread
      setlocal autoread
      call system('chmod 755 ' . expand('%:p'))
      checktime
      let &l:autoread = l:oldautoread
    else
      let l:oldautoread = &autoread
      let l:files = join(a:000)
      call system('chmod 755 ' . l:files)
      checktime
      let &autoread = l:oldautoread
    endif
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
    silent bdel
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

  if NumberOfBuffers() == 1 && empty(expand('%'))
    exe 'silent !echo ' . l:msg_string
    quit!
  else
    echo l:msg_string
  endif
endfunction

function! NumberOfBuffers()
    let i = bufnr('$')
    let j = 0
    while i >= 1
        if buflisted(i)
            let j+=1
        endif
        let i-=1
    endwhile
    return j
endfunction

function! SudoWriteFile()
  " This will write a file that is read-only, using sudo permission
  silent write !sudo tee % >/dev/null
endfunction

let g:open_cmd = ''
if g:os == 'Linux'
  let g:open_cmd = 'xdg-open'
elseif g:os == 'Darwin'
  let g:open_cmd = 'open'
endif " Windows?

function! InsertIFS()
  let l:lines = ['old_IFS=$IFS', "IFS='", "'", 'IFS=$old_IFS']
  for l:line in l:lines
    put=l:line
  endfor
endfunction

function! OpenFunction(...)
  for f in a:000
    echo f
    " asynchronously open f
    call system(g:open_cmd . ' ' . f . '&>/dev/null &')
  endfor
endfunction

function! WC_file(...)
  if (a:0 > 0)
    let l:output = system('wc '.a:1)
    let l:op_list = split(l:output)
  else
    let s:old_status = v:statusmsg
    exe "silent normal! g\<c-g>"
    try
      let s:word_count = str2nr(split(v:statusmsg)[11])
      let s:char_count = str2nr(split(v:statusmsg)[15])
      let v:statusmsg = s:old_status
      " Format: lines: x words: y chars: z
      let l:op_list = [line('$'), s:word_count, s:char_count]
    catch
      echo 'No file'
      return
    endtry
  endif
  highlight NormalUnderlined term=underline cterm=underline gui=underline
  echon 'lines: '  | echohl NormalUnderlined
  echon l:op_list[0] | echohl NONE
  echon ' words: ' | echohl NormalUnderlined
  echon l:op_list[1] | echohl NONE
  echon ' chars: ' | echohl NormalUnderlined
  echon l:op_list[2] | echohl NONE
endfunction

function! WordCount(...)
  if a:0 == 0
    call WC_file() " No parameter
  else
    for f in a:000
      call WC_file(f)
      echon '\t' . f
      echo ''
    endfor
  endif
endfunction

"==== Leader mappings ===="

nmap <silent> <leader>st :SyntasticToggleMode<CR>
nmap          <leader>rf :RenameToken <C-r><C-w><space>
vmap          <leader>rf :RenameToken<space>
nmap          <leader>vg :vimgrep<Space><C-r><C-W><Space>*<CR>

nmap <silent> <leader>qf :<C-u>cwindow<CR>

map  <silent> <leader>ev :<C-u>call EditConfigFile($MYVIMRC)<CR>
map  <silent> <leader>eb :<C-u>call EditConfigFile(expand('~/.bashrc'))<CR>
map  <silent> <leader>et :<C-u>call EditConfigFile(expand('~/.tmux.conf'))<CR>
map  <silent> <leader>sv :<C-u>source $MYVIMRC<CR>
map  <silent> <leader>eh :<C-u>exe 'vsp ' . expand('<cfile>')<CR>
map  <silent> <leader>ef <leader>eh
map  <silent> <leader>ec :<C-u>exe 'vsp ' . expand('<cfile>:r') . '.c'<CR>

map  <silent> <leader>rm :call DeleteThisFile()<CR>

nmap <silent> <leader>f  :echo expand('%')<CR>
nmap <silent> <leader>w  :<C-u>silent call FixWhiteSpace()<CR>

nmap <silent> <leader>sh :!true<CR>
nmap <silent> <leader>m  :make<Up><CR>
nmap <silent> <leader>ru :call RunProject()<CR>
nmap          <leader>2  A >&2<ESC>

nmap          <leader>i  :call InsertIFS()<CR>
nmap <silent> <leader>o  :Open %<CR>
nmap <silent> <leader>p  :call MdToPdf()<CR>
nmap <silent> <leader>u  :call Underline('-')<CR>
nmap <silent> <leader>U  :call Underline('=')<CR>
nmap <silent> <leader>bo :call DrawBox()<CR>
" TODO: Put this in a command, in a plugin
nmap <silent> <leader>3  I### 


"==== Custom Commands ===="

command! -nargs=* -range=% RenameToken <line1>,<line2>
    \ call RenameTokenFunction(<f-args>)

command! -nargs=+ ChangeIndent call ChangeIndentFunc(<f-args>)
command! -nargs=0 Fn echo expand('%')

" Make this file executable
command! -complete=file -nargs=* Chmod call MakeExecutable(<f-args>)

" Enable saving read-only files using sudo
command! W call SudoWriteFile()

" Enable opening a file using vim
command! -complete=file -nargs=+ Open call OpenFunction(<f-args>)

" Unixy things
command! -complete=file -nargs=+ Rm call DeleteThisFile(<f-args>)
command! -complete=file -nargs=* Ls !ls --color=auto <f-args>
command! -complete=file -nargs=* Wc call WordCount(<f-args>)

"====[ Open any file with a pre-existing swapfile in readonly mode ]===="
augroup NoSimultaneousEdits
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
  autocmd SwapExists * echohl ErrorMsg
  autocmd SwapExists * echomsg 'Duplicate edit session (readonly)'
  autocmd SwapExists * echohl None
  autocmd SwapExists * sleep 1
augroup END

"==== Taken from online ===="

" TODO: make this work for multiple :vs edits
" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
      \ if expand('<afile>:p:h') !=? $TEMP |
      \   if line("'\"") > 1 && line("'\"") <= line('$') |
      \     let g:jump_cursor_on_edit_foo = line("'\"") |
      \     let b:doopenfold = 1 |
      \     if (foldlevel(g:jump_cursor_on_edit_foo) >
                \ foldlevel(g:jump_cursor_on_edit_foo - 1)) |
      \      let g:jump_cursor_on_edit_foo = g:jump_cursor_on_edit_foo - 1 |
      \      let b:doopenfold = 2 |
      \     endif |
      \     exe g:jump_cursor_on_edit_foo |
      \   endif |
      \ endif
   " Need to postpone using 'zv' until after reading the modelines.
   autocmd BufWinEnter *
      \ if exists('b:doopenfold') |
      \   exe 'normal! zv' |
      \   if(b:doopenfold > 1) |
      \     exe  '+'.1 |
      \   endif |
      \ unlet b:doopenfold |
      \ endif
augroup END

"==== Make tabs, trailing whitespace, and non-breaking spaces visible but only in non-insert mode===="

exec "set listchars=tab:\uB6~,trail:\uB7,nbsp:~"
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

" Remove any introduced trailing whitespace after moving
let g:DVB_TrimWS = 1

" Move a single char left or right
nmap  <expr>  <C-LEFT>   MoveChar('left')
nmap  <expr>  <C-RIGHT>  MoveChar('right')

"==== Changes list from comma separated to bulleted and back====
"from Instantly better Vim 2013

nmap  <leader>l   :call ListTrans_toggle_format()<CR>
vmap  <leader>l   :call ListTrans_toggle_format('visual')<CR>

"==== Do some math on columns. Instantly better vim ===="
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

"==== Load .vimrc at startup ===="

augroup ConfigReload
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

set nocursorcolumn
