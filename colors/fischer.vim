" Boilerplate
highlight clear
if exists('syntax on')
  syntax reset
endif

hi Cursorline gui=NONE    cterm=NONE                     ctermbg=darkgrey
hi Search     guifg=black guibg=cyan    ctermfg=black    ctermbg=cyan
hi SpellBad   guifg=black guibg=red     ctermfg=black    ctermbg=red
hi SpellCap   guifg=white guibg=blue    ctermfg=white    ctermbg=blue
hi VertSplit  guifg=darkgrey guibg=NONE ctermfg=darkgrey ctermbg=NONE
   \ cterm=bold gui=bold
hi DiffDelete ctermfg=black ctermbg=darkgrey

let g:colors_name = 'fischer'
if &background == 'dark'
  hi Normal     guifg=white guibg=black   ctermfg=white
else
  hi Normal     guifg=black guibg=white   ctermfg=black ctermbg=white
endif
