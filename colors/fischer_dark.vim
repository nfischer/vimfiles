" Boilerplate
highlight clear
if exists('syntax on')
  syntax reset
endif
if &background == 'dark'
  let g:colors_name = 'fischer_dark'

  hi Cursorline gui=NONE    cterm=NONE                     ctermbg=darkgrey
  hi Normal     guifg=white guibg=black   ctermfg=white
  hi Search     guifg=black guibg=cyan    ctermfg=black    ctermbg=cyan
  hi SpellBad   guifg=black guibg=red     ctermfg=black    ctermbg=red
  hi SpellCap   guifg=white guibg=blue    ctermfg=white    ctermbg=blue
  hi VertSplit  guifg=darkgrey guibg=NONE ctermfg=darkgrey ctermbg=NONE
     \ cterm=bold gui=bold

else
  let g:colors_name = 'fischer_dark'

  hi Cursorline gui=NONE    cterm=NONE                     ctermbg=darkgrey
  hi Normal     guifg=black guibg=white   ctermfg=black    ctermbg=white
  hi Search     guifg=black guibg=cyan    ctermfg=black    ctermbg=cyan
  hi SpellBad   guifg=black guibg=red     ctermfg=black    ctermbg=red
  hi SpellCap   guifg=white guibg=blue    ctermfg=white    ctermbg=blue
  hi VertSplit  guifg=darkgrey guibg=NONE ctermfg=darkgrey ctermbg=NONE
     \ cterm=bold gui=bold
endif
