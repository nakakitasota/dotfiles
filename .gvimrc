set encoding=utf-8

" メニューバーを非表示
set guioptions-=m
" ツールバーを非表示
set guioptions-=T
" 右スクロールバーを非表示
set guioptions-=r
set guioptions-=R
" 左スクロールバーを非表示
set guioptions-=l
set guioptions-=L
" 下スクロールバーを非表示
set guioptions-=b

" カラースキーム
colorscheme night-owl

" フォント変更
if has("win64")
    set guifont=HackgenNerd\ Console:h12
elseif has("mac")
    set guifont=HackgenNerd\ Console:h16
elseif has("linux")
    set guifont=HackgenNerd\ Console\ 14
endif

" IME制御:全モードにおいてOFFに固定
set imsearch=0
set iminsert=0
if !has("win64")
    if has("kaoriya")
        set imdisable
    endif
endif

" IMの状態に応じてカーソルの色を変える
if has('xim') || has('multi_byte_ime')
    highlight Cursor guifg=NONE guibg=Green
    highlight CursorIM guifg=NONE guibg=Red
endif

" 透過設定
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
" ノーマルモード:TransparencyToggleで背景透過切り換え
if has("kaoriya")
    command TransparencyToggle call TransparencyToggle()
endif

" 終了時のウィンドウサイズ・位置を覚える
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

