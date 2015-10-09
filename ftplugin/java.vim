" Java filetype plugin

set et
set shiftwidth=4 tabstop=4 softtabstop=4
if v:version < 704
    set formatoptions=qnl              " Add the options I want
else
    set formatoptions=qnlj
endif
