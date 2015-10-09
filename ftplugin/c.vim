" C filetype plugin

set et
set shiftwidth=2 tabstop=2 softtabstop=2
if v:version < 704
    set formatoptions=qnl              " Add the options I want
else
    set formatoptions=qnlj
endif
