nnoremap <silent>sf :<C-u>Fern %:h -reveal=%:p<CR>

let g:fern#disable_default_mappings = 1
let g:fern#default_hidden= 1
let g:fern#scheme#file#show_absolute_path_on_root_label = 1
let g:fern#renderer = "devicons"

autocmd FileType fern call s:fern_my_settings()
function! s:fern_my_settings() abort
    nnoremap <silent><buffer> <CR>
    \ <Plug>(fern-action-open)
    nnoremap <silent><buffer> c
    \ <Plug>(fern-action-clipboard-copy)
    nnoremap <silent><buffer> m
    \ <Plug>(fern-action-clipboard-move)
    nnoremap <silent><buffer> p
    \ <Plug>(fern-action-clipboard-paste)
    nnoremap <silent><buffer> l
    \ <Plug>(fern-action-open)
    nnoremap <silent><buffer><expr> o
    \ fern#smart#leaf(
    \     "",
    \     "<Plug>(fern-action-expand:stay)",
    \     "<Plug>(fern-action-collapse)",
    \ )
    nnoremap <silent><buffer> K
    \ <Plug>(fern-action-new-dir)
    nnoremap <silent><buffer> N
    \ <Plug>(fern-action-new-file)
    nnoremap <silent><buffer> d
    \ <Plug>(fern-action-remove)
    nnoremap <silent><buffer> r
    \ <Plug>(fern-action-move)
    nnoremap <silent><buffer> R
    \ <Plug>(fern-action-rename)
    nnoremap <silent><buffer> x
    \ <Plug>(fern-action-open:system)
    nnoremap <silent><buffer> yy
    \ <Plug>(fern-action-yank)
    nnoremap <silent><buffer> <C-h>
    \ <Plug>(fern-action-hidden:toggle)
    nnoremap <silent><buffer> h
    \ <Plug>(fern-action-leave)
    nnoremap <silent><buffer> ~
    \ <Cmd>Fern ~<CR>
    nnoremap <silent><buffer><expr> q
    \ !len(getbufinfo({'buflisted':1})) ? "<Cmd>bdelete<CR>" : "<Cmd>bprevious<CR>"
    nnoremap <silent><buffer><nowait> <Space>
    \ <Plug>(fern-action-mark:toggle)<Down>
    nnoremap <silent><buffer><expr> j
    \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
    \ line('.') == 1 ? 'G' : 'k'
endfunction
