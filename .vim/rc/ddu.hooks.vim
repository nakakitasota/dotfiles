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
    \             "winWidth": float2nr(&columns * s:ddu_win_width_percent),
    \             "winHeight": float2nr(&lines * s:ddu_win_height_percent),
    \             "winCol": float2nr((&columns - (&columns * s:ddu_win_width_percent)) / 2),
    \             "winRow": float2nr((&lines - (&lines * s:ddu_win_height_percent)) / 2),
    \             "previewWidth": float2nr((&columns * s:ddu_win_width_percent) / 2 - 2),
    \             "previewHeight": float2nr(&lines * s:ddu_win_height_percent - 2),
    \             "previewCol": float2nr(&columns / 2),
    \             "previewRow": float2nr((&lines - (&lines * s:ddu_win_height_percent)) / 2 + 1),
    \             "autoAction": { "name": "preview", "delay": 0},
    \             "startAutoAction": v:true,
    \         }
    \     }
    \ })

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
