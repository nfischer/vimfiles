" ===============================================================
" High-level variables {{{
" ===============================================================

let g:mapleader = ','
let g:local_vimrc = $HOME . '/.vimrc.local'

" }}}
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
set nofixendofline          " It's OK if a file doesn't have a trailing newline
set nojoinspaces            " Only insert a single space after punctuation
set noshowmode              " Handled by airline/lightline
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
" remote plugins (python3, ruby, etc.) {{{
" ===============================================================

" Only query python3 to avoid loading python2 during startup. Python3 should be
" sufficient for most plugins at this point. `loaded_python_provider = 0` isn't
" strictly necessary (it's sufficient to just not query py2), but this avoids
" regressions if some plugin queries py2.
let g:loaded_python_provider = 0
let g:has_python = has('python3')

" Disable the ruby provider.
let g:loaded_ruby_provider = 0

" Disable the perl provider.
let g:loaded_perl_provider = 0

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

let g:plug_window = 'enew'

call plug#begin(s:VIMFILES . '/plugged')

Plug 'SirVer/ultisnips',        Cond(g:has_python && v:version >= 800)
Plug 'Valloric/MatchTagAlways', Cond(g:has_python, {'for': ['html', 'xml', 'jinja']})
Plug 'google/vim-codefmt',      Cond(g:has_python, {'for': ['gn'], 'on': ['FormatCode', 'FormatLines']})
Plug 'google/vim-glaive',       Cond(g:has_python)
Plug 'google/vim-maktaba',      Cond(g:has_python)

Plug 'Shougo/deoplete.nvim', Cond(has('nvim') && has('python3'), { 'do': ':UpdateRemotePlugins' })
Plug 'Shougo/neocomplete.vim', Cond(!has('nvim') && has('lua') && v:version >= 703 && !has('patch-8.2.1066'))

Plug 'chrisbra/vim-diff-enhanced', Cond(v:version >= 704)


let g:treesitter_loaded = has('nvim') && has('nvim-0.6')
let g:nvim_gitsigns_loaded = has('nvim') && has('nvim-0.8')
let g:nvim_comment_loaded = has('nvim') && has('nvim-0.7')

Plug 'nvim-treesitter/nvim-treesitter', Cond(g:treesitter_loaded, {'do': ':TSUpdate'})
Plug 'nvim-treesitter/nvim-treesitter-refactor', Cond(g:treesitter_loaded)
Plug 'nvim-treesitter/nvim-treesitter-textobjects', Cond(g:treesitter_loaded)
" Git signs:
Plug 'airblade/vim-gitgutter', Cond(!g:nvim_gitsigns_loaded)
Plug 'lewis6991/gitsigns.nvim', Cond(g:nvim_gitsigns_loaded)
" Commenting:
Plug 'tpope/vim-commentary', Cond(!g:nvim_comment_loaded)
Plug 'numToStr/Comment.nvim', Cond(g:nvim_comment_loaded)

" Obsolete as neovim and vim (since version 8.2.2345) have native support
let g:tmux_focus_events_builtin = has('nvim') || (v:version >= 802 && has('patch2345'))
Plug 'tmux-plugins/vim-tmux-focus-events', Cond(!g:tmux_focus_events_builtin)

Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'alvan/vim-closetag'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dag/vim-fish'
Plug 'deoplete-plugins/deoplete-zsh'
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'mileszs/ack.vim'
Plug 'miyakogi/conoline.vim'
Plug 'nfischer/vim-ohm'
Plug 'nfischer/vim-potigol'
Plug 'nfischer/vim-rainbows'
Plug 'pangloss/vim-javascript'
Plug 'rgrinberg/vim-ocaml'
Plug 'rhysd/vim-crystal'
Plug 'rhysd/vim-gfm-syntax'
Plug 'rhysd/vim-syntax-christmas-tree'
Plug 'snaewe/Instantly_Better_Vim_2013'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tyrannicaltoucan/vim-quantum' | let s:quantum_loaded = 1
Plug 'udalov/kotlin-vim'
Plug 'vim-scripts/proguard.vim'
Plug 'wellle/tmux-complete.vim'
Plug 'whatyouhide/vim-lengthmatters'
Plug 'wlangstroth/vim-racket'

Plug 'https://gn.googlesource.com/gn', { 'rtp': 'misc/vim' }

let s:local_vimplug = $HOME . '/.local-plugins.vim'
if filereadable(s:local_vimplug)
  execute 'source' . s:local_vimplug
endif

call plug#end()

if g:has_python
  call glaive#Install()
endif

" }}}
" ===============================================================
" Plugin settings {{{
" ===============================================================

if g:nvim_comment_loaded
lua << EOF
require('Comment').setup()
EOF
endif

if g:nvim_gitsigns_loaded
lua <<EOF
-- Adapted from https://github.com/lewis6991/gitsigns.nvim
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk({wrap=false}) end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk({wrap=false}) end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
EOF
endif

" Treesitter
if g:treesitter_loaded
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Run `:h syntax` and tree-sitter together. The main reason for doing
    -- this is to get proper indentation.
    additional_vim_regex_highlighting = true
  },
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'grr',
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
      include_surrounding_whitespace = function(selection)
        -- These text objects include surrounding whitespace (ex. blank lines
        -- after a function definition).
        local queries = {
          '@function.outer',
          '@class.outer',
        }

        return vim.tbl_contains(queries, selection.query_string)
      end,
    },
  },
}
EOF
endif

" Lengthmatters plugin
let g:lengthmatters_excluded = ['unite', 'tagbar', 'startify', 'gundo',
  \ 'vimshell', 'w3m', 'nerdtree', 'help', 'qf', 'dirvish', 'log', 'txt']

" Configure markdown highlighting. See
" https://github.com/github/linguist/blob/master/lib/linguist/languages.yml
let g:markdown_fenced_languages = [
  \ 'c',
  \ 'cpp', 'cc=cpp',
  \ 'gn',
  \ 'html',
  \ 'java',
  \ 'javascript', 'js=javascript',
  \ 'json',
  \ 'python',
  \ 'sh', 'bash=sh', 'shell=sh',
  \ 'vim',
  \ 'xml',
  \ ]

" Tmux stuff
let g:tmux_navigator_disable_when_zoomed = 1

" See https://github.com/christoomey/vim-tmux-navigator/issues/189
function! NetrwMapping()
  nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
endfunction
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

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
  let g:lightline = {
      \ 'colorscheme': 'quantum',
      \ }
  let g:quantum_black = 1
  colorscheme quantum
endif
syntax on

let g:conoline_color_normal_nr_dark = 'guifg=#69c5ce guibg=#181818'
let g:conoline_color_insert_nr_dark = 'guifg=#69c5ce guibg=#000000'

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

" Airline/lightline settings
if has('nvim') && has('nvim-0.7.2')
  " Global status line (across all windows)
  set laststatus=3
else
  set laststatus=2
endif

" PatienceDiff settings
if v:version >= 704
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

" Fugitive settings
nnoremap <silent> <leader>gdm :<C-u>let __diff_cmd = 'Gdiffsplit ' . GitMainBranch()\|exe __diff_cmd\|echo __diff_cmd<CR>
nnoremap <silent> <leader>ga  :<C-u>Gwrite<CR>
nnoremap <silent> <leader>gb  :<C-u>Git blame<CR>
nnoremap <silent> <leader>gdd :<C-u>Gdiffsplit<CR>
nnoremap          <leader>gh  :<C-u>Gdiffsplit HEAD~
nnoremap <silent> <leader>gh1 :<C-u>Gdiffsplit HEAD~1<CR>
nnoremap <silent> <leader>ghh :<C-u>Gdiffsplit HEAD<CR>
nnoremap <silent> <leader>gH  :<C-u>Gdiffsplit HEAD<CR>
nnoremap <silent> <leader>gi  :<C-u>GEditIgnore<CR>
nnoremap <silent> <leader>gs  :<C-u>Git<CR>

" Vim-plug mappings
nnoremap <silent> <leader>vu :<C-u>PlugUpdate<CR>
nnoremap <silent> <leader>vi :<C-u>PlugInstall<CR>
augroup VimPlug
  autocmd!
  " Jump directly into the commit preview.
  autocmd FileType vim-plug nmap <buffer> o <plug>(plug-preview)<c-w>P
augroup END

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

" Nvim 0.v5 changed the undofile format in a backward incompatible way.
if has('nvim-0.5')
  call s:SetAndMake('undodir', 'nvim_undodir')
else
  call s:SetAndMake('undodir', 'undodir')
endif

" }}}
" ===============================================================
" Key mappings {{{
" ===============================================================

nnoremap <silent> <C-Up> :call RunLastCommandInLastPane()<CR>

noremap  ;  :
noremap  <Bslash>  ;

" Space should do something useful
nnoremap <silent> <space> :w<CR>

" Macros should be easy to apply
nnoremap Q @q

" Force tmux to respect <C-a>
cnoremap  <C-a> <home>

" Prevents annoying behavior
nnoremap <silent> K     k:echoerr 'CAPSLOCK IS ON'<CR>
nnoremap <silent> J     j:echoerr 'CAPSLOCK IS ON'<CR>
vnoremap <silent> K     k:<C-u>echoerr 'CAPSLOCK IS ON'<CR>gv
vnoremap <silent> J     j:<C-u>echoerr 'CAPSLOCK IS ON'<CR>gv
cnoremap          q~    q!
cnoremap          q1    q!

" Clear/refresh the screen
nnoremap <silent> <leader>ll :<C-u>nohl<CR><C-l>

" Adjust yanking to be more consistent with other conventions
nnoremap Y y$

" Spell checking
if exists('+spelllang')
  set spelllang=en_us
endif
nnoremap <silent> <leader>sp :setlocal spell!<Bar>set spell?<CR>
vnoremap <silent> <leader>sp :<C-u>setlocal spell!<CR>gv
inoremap <C-l> <Esc>[s1z=`]a

" }}}
" ===============================================================
" Custom text objects {{{
" ===============================================================

" From https://github.com/junegunn/dotfiles/blob/master/vimrc

" ie: inner entire (entire buffer)
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>

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

"==== Do some math on columns. Instantly better vim ===="
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

" }}}
" ===============================================================
" Leader functions {{{
" ===============================================================

function! RunLastCommandInLastPane()
  " Note: '!' is shorthand for 'previously active pane' (e.g., the
  " last/most-recent pane we used).
  Tmux send-keys -t '!' 'Up' 'C-m'
endfunction

function! SearchAllBuffers(query)
  let l:mybuf = bufnr('%')
  cex []
  silent! exe 'bufdo vimgrepadd! /' . a:query . '/ %'
  if len(getqflist()) == 0
    silent exe 'buffer' l:mybuf
    echohl WarningMsg | echomsg 'Unable to find a match for' a:query | echohl NONE
  else
    echohl Question | echomsg 'Results are loaded in your quickfix list' | echohl NONE
  endif
endfunction

function! s:Diffoff()
  let l:currwin = winnr()
  " let l:mybuf = bufnr('%')
  windo diffoff
  " silent exe 'buffer' l:mybuf
  silent exe currwin . 'wincmd w'
endfunction

let g:default_git_main_branches = [
  \ 'main',
  \ 'master',
  \ ]
let g:git_main_branches = g:default_git_main_branches
function! GitMainBranch()
  for l:branch in g:git_main_branches
    if !empty(system('git branch --list ' . l:branch))
      return l:branch
    endif
  endfor
  return l:branch
endfunction

function! s:RenameTokenFunction(orig, new) range
  if a:orig ==# a:new
    echohl WarningMsg | echomsg 'These are the same thing!' | echohl NONE
    return
  endif

  " Save search register, to restore later. Note we can't save the cursor
  " position because this is a range function, so the cursor position is reset
  " to line 1 before the function call starts.
  let l:old_gdefault = &gdefault
  let l:old_search = getreg('/')

  let l:reset_pos = 1
  if !search('\<' . a:orig . '\>', 'nw')
    let l:reset_pos = 0
  endif

  " Do a global replace
  set nogdefault
  try
    exe a:firstline . ',' . a:lastline . 's/\C\<' . a:orig . '\>/' . a:new
        \ . '/g'
    echo a:orig . ' -> ' . a:new
  catch
    let l:msg = 'Did not find the term `' . a:orig . '`'
    echohl WarningMsg | echomsg l:msg | echohl NONE
  finally
    " Restore values.
    let &gdefault = l:old_gdefault
    call setreg('/', l:old_search)
  endtry
endfunction

function! MoveSplit(dir)
  if (winnr() == 1 && a:dir ==# 'left') ||
      \ (winnr() == winnr('$') && a:dir !=# 'left')
    " Move to the left
    vertical resize -5
  else
    " Move to the right
    vertical resize +5
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
  " Replace the %s with the todo message, and make sure we're padded by spaces
  " on either side
  let l:full_text = substitute(&commentstring, '\v *\%s *', ' ' . l:todo_str . ' ', '')
  let l:full_text = substitute(l:full_text, '\v +$', '', '')

  " Fetch the appropriate indentation
  let l:line_text = getline('.')
  let l:indent = matchstr(l:line_text, '^\s*')
  put!=l:indent . l:full_text
endfunction

"==== Edit .vimrc quickly ===="
function! EditConfigFile(config_name, ...)
  let l:config_name = resolve(a:config_name) " Follow symlinks
  if !filewritable(l:config_name)
    let l:msg = l:config_name . " can't be edited"
    echohl ErrorMsg | echo l:msg | echohl NONE
  else
    let l:fname = expand('%:p')
    if line('$') == 1 && empty(getline(1)) && empty(l:fname)
      " We're not editing anything interesting, so open in a full window
      exe 'edit ' . l:config_name
    elseif l:fname ==# l:config_name && !exists('s:warned_for_file')
      let l:msg = 'Already editing ' . expand('%:t') . '. Try again to open'
      echohl WarningMsg | echo l:msg | echohl NONE
      let s:warned_for_file = 1
    else
      exe 'vsp ' . l:config_name
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
noremap  <silent> <leader>eV :<C-u>call EditConfigFile(g:local_vimrc)<CR>
noremap  <silent> <leader>eB :<C-u>call EditConfigFile(expand('~/.bashrc.local'))<CR>
noremap  <silent> <leader>eZ :<C-u>call EditConfigFile(expand('~/.zshrc.local'))<CR>
noremap  <silent> <leader>et :<C-u>call
    \ EditConfigFile(expand('~/.tmux.conf'))<CR>

nnoremap <silent> <leader>w  :<C-u>silent call FixWhiteSpace()<CR>

nnoremap <silent> <leader>ff :<C-u>GFiles<CR>
nnoremap <silent> <leader>fg :<C-u>GFiles?<CR>
nnoremap <silent> <leader>fb :<C-u>Buffers<CR>

nnoremap          <leader>2  A >&2<ESC>

" Tell me the syntax group under the cursor
nnoremap <leader>S :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" }}}
" ===============================================================
" Custom Commands {{{
" ===============================================================

" Simpler diffing commands
command! -nargs=0                        Diff windo diffthis
command! -nargs=0                        Diffoff call s:Diffoff()

command! -nargs=*                        Search  call SearchAllBuffers(<q-args>)
command! -complete=file -nargs=1         Browser !x-www-browser <args> &>/dev/null &
command! -nargs=0                        Yank normal! ggVG"+y``
command! -nargs=0                        Blast normal! ggVG"+p

command! -nargs=0                        LongLines call setreg('/', '\m^.\{81,}$')|
    \ echo 'press n to go to the next long line'
command! -nargs=1                        Todo call s:AddTodo(<q-args>)
command! -nargs=+ -complete=command      Profile echo HowLong(<f-args>)

"  TODO(nate): Move this into a separate plugin
command! -nargs=* -complete=var -range=% RenameToken
    \ let b:rename_token_win_view = winsaveview() |
    \ <line1>,<line2>call s:RenameTokenFunction(<f-args>) |
    \ call winrestview(b:rename_token_win_view) |
    \ unlet b:rename_token_win_view

" Enable saving read-only files using sudo
command! -nargs=0                        W call s:SudoWriteFile()

" Unixy things (that eunuch.vim missed)
command! -nargs=+ -complete=file         Open call s:OpenFunction(<f-args>)
command! -nargs=* -complete=file         Ls echo system('ls --color=auto ' . <q-args>)
command! -nargs=* -complete=file         Wc call s:WordCount(<f-args>)

" }}}
" ===============================================================
" Spelling/Typos {{{
" ===============================================================

function! s:Typo(mispelled, correct)
  exe 'command! -nargs=* ' . a:mispelled . ' ' . a:correct . ' <args>'
endfunction
command! -nargs=+ Typo call s:Typo(<f-args>)

" Avoid :cnoreabbrev if possible, because it affects searches as well.
Typo LengthMattersDisable LengthmattersDisable
Typo Tood Todo
Typo TMux Tmux

" }}}
" ===============================================================
" Autocommands {{{
" ===============================================================

augroup CodeFmt
  autocmd!
  autocmd FileType gn AutoFormatBuffer gn
augroup END

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
    normal! zv
    if(b:doopenfold > 1)
      normal! <CR>
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
  exe 'autocmd BufWritePost ' . g:local_vimrc . ' source ' . g:local_vimrc
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

function! s:GitCommitSyntax()
  " TODO(nfischer): consider implementing hashtag highlighting
  syntax match Type '\v\C^(Bug|Fixed|Test|Change-Id|Merged-In):@='
  syntax match SpellBad '\v\C^(Fixes):@=' " should be 'Fixed'
endfunction

function! s:GitCommitAbbrev()
  inoreabbrev <buffer> b: Bug:
  inoreabbrev <buffer> t: Test:
  inoreabbrev <buffer> f: Fixed:
  inoreabbrev <buffer> nctl No change to logic
endfunction

augroup FileTypeOptions
  " Configure comment patterns and other things
  autocmd!
  autocmd FileType c,cpp,cs,java            setlocal commentstring=//\ %s
  autocmd FileType bash,python              setlocal commentstring=#\ %s
  autocmd FileType crontab                  setlocal commentstring=#\ %s
  autocmd FileType vim                      setlocal commentstring=\"\ %s
  autocmd FileType sql                      setlocal commentstring=--\ %s

  autocmd FileType markdown                 setlocal spell
  autocmd FileType markdown                 setlocal commentstring=<!--%s-->
  " Workaround https://github.com/elzr/vim-json/issues/104
  autocmd BufNewfile,BufReadPost *.md       setlocal conceallevel=0

  autocmd FileType gitcommit                setlocal nofoldenable
  autocmd FileType gitcommit                setlocal spell
  autocmd FileType gitcommit                call s:GitCommitSyntax()
  autocmd FileType gitcommit                call s:GitCommitAbbrev()
  autocmd FileType gitcommit                normal! gg

  autocmd FileType gitconfig                setlocal noexpandtab

  autocmd FileType scheme                   setlocal lisp

  if has('nvim') && has('nvim-0.8')
  lua <<EOF
  vim.filetype.add({
    extension = {
      md = 'markdown',
      pl = 'prolog',
      pro = 'proguard',
      flags = 'proguard',
      ['zsh-theme'] = 'zsh',
      mojom = 'cpp',
      aidl = 'java',
    },
    filename = {
      ['.gitconfig.local'] = 'gitconfig',
      ['gitconfig'] = 'gitconfig',
    },
  })
EOF
  else
    autocmd BufNewfile,BufReadPost *.md set filetype=markdown
    autocmd BufNewfile,BufReadPost *.pl set filetype=prolog
    autocmd BufNewfile,BufReadPost *.pro,*.flags set filetype=proguard
    autocmd BufNewfile,BufReadPost *.zsh-theme set filetype=zsh
    autocmd BufNewfile,BufReadPost gitconfig,.gitconfig.local set filetype=gitconfig
    autocmd BufNewFile,BufReadPost *.mojom setfiletype cpp
    autocmd BufNewFile,BufReadPost *.aidl setfiletype java
  endif
augroup END

"==== Make whitespace visible, but not in insert mode ===="
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

" Configure how whitespace characters appear
" vint: -ProhibitUnnecessaryDoubleQuote
exe "set listchars=tab:\uB6~,trail:\uB7,nbsp:~"
" vint: +ProhibitUnnecessaryDoubleQuote

"==== Vim Window setup ===="
nnoremap <silent> <C-w>h :call MoveSplit('left')<CR>
nnoremap <silent> <C-w>l :call MoveSplit('right')<CR>

" }}}
" ===============================================================
" After {{{
" ===============================================================

" These settings need to be reset near the end of the vimrc
set nocursorcolumn
nohlsearch

" }}}
" ===============================================================
" Local vimrc {{{
" ===============================================================

if filereadable(g:local_vimrc)
  execute 'source' . g:local_vimrc
endif

" }}}
" ===============================================================
