let s:badopts="crot"

for s:k in split(s:badopts, '\zs')
    " Remove each option one at a time
    exe "au FileType * set formatoptions-=" . s:k
endfor
