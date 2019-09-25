execute pathogen#infect()
syntax on
filetype plugin indent on
set softtabstop=2 expandtab shiftwidth=2 autoindent
set nobackup
set nowritebackup
set noswapfile
set nowrap

vmap \| :EasyAlign *\|<CR>

let g:TestKey = { 'runners': {} }

let g:TestKey.runners.elm = { 'match': '\.elm$' }
function g:TestKey.runners.elm.run(file, line)
  return ':!clear && bin/elm make '.a:file.' --output /dev/null'
endfunction

let g:TestKey.runners.rust = { 'match': '\.rs$' }
function g:TestKey.runners.rust.run(file, line)
  return ':!clear && cargo test -j1'
endfunction

