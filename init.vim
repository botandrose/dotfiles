execute pathogen#infect()
syntax on
filetype plugin indent on
set softtabstop=2 expandtab shiftwidth=2 autoindent
set nobackup
set nowritebackup
set noswapfile
set nowrap

command W write

command -nargs=1 We :w <args> | :e <args>
cnoreabbrev we We

vmap \| :EasyAlign *\|<CR>

function! AlignTable()
  let start_line = line('.')
  let end_line = line('.')

  " Search upward for the start of the table
  while start_line > 1 && getline(start_line - 1) =~ '|'
    let start_line -= 1
  endwhile

  " Search downward for the end of the table
  while end_line < line('$') && getline(end_line + 1) =~ '|'
    let end_line += 1
  endwhile

  " Apply EasyAlign to the range
  execute start_line . ',' . end_line . 'EasyAlign *|'
endfunction

nnoremap <silent> <bar><bar> :<C-u>call AlignTable()<CR>

let g:TestKey = { 'runners': {} }

let g:TestKey.runners.elm = { 'match': '\.elm$' }
function g:TestKey.runners.elm.run(file, line)
  return ':!clear && bin/elm make '.a:file.' --output /dev/null'
endfunction

let g:TestKey.runners.rust = { 'match': '\.rs$' }
function g:TestKey.runners.rust.run(file, line)
  return ':!clear && cargo test -j1'
endfunction

let g:TestKey.runners.minitest = { 'match': '_test\.rb$' }
function g:TestKey.runners.minitest.run(file, line)
  return ':!clear && rake test TEST='.a:file
endfunction

