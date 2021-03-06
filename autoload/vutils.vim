if exists("g:autoloaded_vutils")
  finish
endif

let g:autoloaded_vutils = 1

" Save last search and cursor position before executing a command
" http://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
function! vutils#preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Same as preserve but wraps function ref
function! vutils#preserve_wrapper(funcref)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    call a:funcref()
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Taken from ctrlp help file
function! vutils#root_dir()
    let cph = expand('%:p:h', 1)
    if cph =~ '^.\+://' | retu | en
    for mkr in g:root_dir_markers
        let wd = call('find'.(mkr =~ '/$' ? 'dir' : 'file'), [mkr, cph.';'])
        if wd != '' | let &acd = 0 | brea | en
    endfo
    return fnameescape(wd == '' ? cph : substitute(wd, mkr.'$', '.', ''))
endfunction

function! vutils#cd_rootdir()
    exe ':lcd '.vutils#root_dir()
endfunction

function! vutils#syntax()
    return synIDattr(synID(line("."),col("."),1),"name")
endfunction

function! vutils#toggle_et()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
    echo "using tabs"
  else
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    echo "using spaces"
  endif
endfunction

