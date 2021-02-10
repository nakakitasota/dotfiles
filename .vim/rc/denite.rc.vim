nmap <silent> <Space>f :<C-u>Denite file/rec<CR>
nmap <silent> <Space>r :<C-u>Denite file/old<CR>
nmap <silent> <Space>g :<C-u>Denite grep<CR>
nmap <silent> <Space>b :<C-u>Denite buffer<CR>
nmap <silent> <Space>l :<C-u>Denite line<CR>

augroup denite_filter
    autocmd FileType denite call s:denite_my_settings()
    function! s:denite_my_settings() abort
        nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
        nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> <ESC>
        \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space>
        \ denite#do_map('toggle_select').'j'
        imap <silent><buffer> <C-n> <Plug>(denite_filter_quit)<DOWN>
        imap <silent><buffer> <C-p> <Plug>(denite_filter_quit)<UP>
        imap <silent><buffer> <CR> <Plug>(denite_filter_quit)<CR>
    endfunction
augroup END

" use ripgrep
if executable('rg')
    call denite#custom#var('file_rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
endif

" options
let s:denite_options = {
    \ 'start_filter': v:true,
    \ }

let s:denite_win_width_percent = 0.8
let s:denite_win_height_percent = 0.7

let s:denite_floating_options = {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ 'prompt': 'λ ',
    \ }

call denite#custom#option('default', s:denite_options)

" use floating
if has('nvim')
    call denite#custom#option('default', s:denite_floating_options)
endif
