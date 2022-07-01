set encoding=utf-8

" Remove menu bar
set guioptions-=m
" Remove tool bar
set guioptions-=T
" Remove scroll bar
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

" colorscheme
colorscheme night-owl

" font
if has("win64")
    set guifont=HackgenNerd\ Console:h12
elseif has("mac")
    set guifont=HackgenNerd\ Console:h16
elseif has("linux")
    set guifont=HackgenNerd\ Console\ 14
endif

" input method control
set imsearch=0
set iminsert=0
if !has("win64")
    if has("kaoriya")
        set imdisable
    endif
endif

" Change cursor color according to IM status
if has('xim') || has('multi_byte_ime')
    highlight Cursor guifg=NONE guibg=Green
    highlight CursorIM guifg=NONE guibg=Red
endif

" transparency
function! TransparencyToggle()
    if has("mac")
        if &transparency == 0
            set transparency=10
        else
            set transparency=0
        endif
    elseif has("win64")
        if &transparency == 255
            set transparency=230
        else
            set transparency=255
        endif
    endif
endfunction
" command for switching transparency
if has("kaoriya")
    command TransparencyToggle call TransparencyToggle()
endif

" Remember window size and position
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
    autocmd!
    autocmd VimLeavePre * call s:save_window()
    function! s:save_window()
        let options = [
            \ 'set columns=' . &columns,
            \ 'set lines=' . &lines,
            \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
            \ ]
      call writefile(options, g:save_window_file)
    endfunction
augroup END

if filereadable(g:save_window_file)
    execute 'source' g:save_window_file
endif
