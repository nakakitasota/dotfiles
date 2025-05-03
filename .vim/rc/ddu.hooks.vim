" hook_add {{{
nnoremap [Finder] <Nop>
nmap <Space>f [Finder]

nnoremap <silent> [Finder]f :Ddu file_rec<CR>
nnoremap <silent> [Finder]r :Ddu file_old<CR>
nnoremap <silent> [Finder]g :DduRg<CR>
nnoremap <silent> [Finder]b :Ddu buffer<CR>
nnoremap <silent> [Finder]l :Ddu line<CR>
" }}}

" hook_source {{{
let s:ddu_win_width_percent = 0.8
let s:ddu_win_height_percent = 0.7

call ddu#custom#patch_global({
    \     "ui": "ff",
    \     "sourceOptions": {
    \         "_": {
    \             "matchers": ["matcher_substring"],
    \             "ignoreCase": v:true
    \         },
    \         "file_rec": {
    \             "converters": ["converter_devicon"]
    \         },
    \         "file_old": {
    \             "converters": ["converter_devicon"]
    \         },
    \     },
    \     "sourceParams": {
    \         "file_rec": {
    \             "ignoredDirectories": [".git", "node_modules"]
    \         },
    \     },
    \     "kindOptions": {
    \         "file": {
    \             "defaultAction": "open"
    \         },
    \     },
    \     "uiParams": {
    \         "ff": {
    \             "split": has("nvim") ? "floating" : "horizontal",
    \             "prompt": "Filter> ",
    \             "previewSplit": "vertical",
    \             "previewFloating": has("nvim") ? v:true : v:false,
    \             "previewFloatingBorder": "single",
    \             "floatingBorder": "single",
    \             "autoAction": { "name": "preview", "delay": 0},
    \             "startAutoAction": v:true,
    \         }
    \     }
    \ })

function s:resize_dduff_floating() abort
    let is_landscape = &columns > &lines * 3
    let ddu_width = float2nr(&columns * s:ddu_win_width_percent)
    let ddu_height = float2nr(&lines * s:ddu_win_height_percent)
    let ddu_margin_x = float2nr((&columns - ddu_width) / 2)
    let ddu_margin_y = float2nr((&lines - ddu_height) / 2)

    if is_landscape
        let win_width = float2nr(ddu_width / 2 - 2)
        let win_height = ddu_height
        let win_col = ddu_margin_x
        let win_row = ddu_margin_y
        let preview_col = ddu_margin_x + win_width + 2
        let preview_row = ddu_margin_y
    else
        let win_width = ddu_width
        let win_height = float2nr(ddu_height / 2 - 2)
        let win_col = ddu_margin_x
        let win_row = ddu_margin_y
        let preview_col = ddu_margin_x
        let preview_row = ddu_margin_y + win_height + 2
    endif

    call ddu#custom#patch_global(#{
        \ uiParams: #{
        \     ff: #{
        \         winWidth: win_width,
        \         winHeight: win_height,
        \         winCol: win_col,
        \         winRow: win_row,
        \         previewWidth: win_width,
        \         previewHeight: win_height,
        \         previewCol: preview_col,
        \         previewRow: preview_row,
        \     }
        \ }
    \ })
endfunction
call s:resize_dduff_floating()
autocmd VimResized * call s:resize_dduff_floating()

" open filter window automatically
autocmd User Ddu:uiDone ++nested call ddu#ui#async_action('openFilterWindow')
" }}}

" ddu-ff {{{
nnoremap <buffer> <CR>
\ <Cmd>call ddu#ui#do_action('itemAction')<CR>
nnoremap <buffer> <Space>
\ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
nnoremap <buffer> i
\ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
nnoremap <buffer> q
\ <Cmd>call ddu#ui#do_action('quit')<CR>
" }}}
