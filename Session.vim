let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Nix/Editor
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +181 ./conf.nixvim.nix
badd +2 ~/Nix/Editor/conf.nixvim.options.nix
badd +0 lua/settings.lua
argglobal
%argdel
$argadd ./conf.nixvim.nix
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit lua/settings.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 25 + 26) / 53)
exe '2resize ' . ((&lines * 24 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 66 + 66) / 132)
exe '3resize ' . ((&lines * 24 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 65 + 66) / 132)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=6
setlocal fml=1
setlocal fdn=20
setlocal fen
2
normal! zo
3
normal! zo
let s:l = 7 - ((6 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 7
normal! 08|
wincmd w
argglobal
if bufexists(fnamemodify("~/Nix/Editor/conf.nixvim.options.nix", ":p")) | buffer ~/Nix/Editor/conf.nixvim.options.nix | else | edit ~/Nix/Editor/conf.nixvim.options.nix | endif
if &buftype ==# 'terminal'
  silent file ~/Nix/Editor/conf.nixvim.options.nix
endif
balt ./conf.nixvim.nix
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 13 - ((12 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 13
normal! 03|
wincmd w
argglobal
if bufexists(fnamemodify("./conf.nixvim.nix", ":p")) | buffer ./conf.nixvim.nix | else | edit ./conf.nixvim.nix | endif
if &buftype ==# 'terminal'
  silent file ./conf.nixvim.nix
endif
balt ./conf.nixvim.nix
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=6
setlocal fml=1
setlocal fdn=20
setlocal fen
18
normal! zo
44
normal! zo
119
normal! zo
let s:l = 100 - ((11 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 100
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 25 + 26) / 53)
exe '2resize ' . ((&lines * 24 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 66 + 66) / 132)
exe '3resize ' . ((&lines * 24 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 65 + 66) / 132)
tabnext
argglobal
enew | setl bt=help
help 'wildmenu'@en
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
silent! normal! zE
let &fdl = &fdl
let s:l = 6933 - ((2 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 6933
normal! 033|
tabnext 1
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
