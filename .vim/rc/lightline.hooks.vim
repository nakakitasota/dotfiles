" hook_add {{{
let g:lightline = {
    \ 'colorscheme': 'nightfly',
    \ 'mode_map': {'c': 'NORMAL'},
    \ 'active': {
    \     'left': [
    \         ['mode', 'paste'],
    \         ['gitbranch', 'readonly', 'filename'],
    \         ['cocstatus'],
    \     ],
    \     'right': [
    \         ['lineinfo', 'syntastic'],
    \         ['percent'],
    \         ['charcode', 'fileformat', 'fileencoding', 'filetype'],
    \     ]
    \ },
    \ 'component_function': {
    \     'filename': 'LightlineFilename',
    \     'gitbranch': 'LightlineGitbranch',
    \     'cocstatus': 'LightlineCocStatus',
    \ }
    \ }

function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

function! LightlineGitbranch()
    let icon = "\ue0a0"
    let branch = FugitiveHead()
    let status = branch != '' ? icon . ' ' . branch : ''
    return status
endfunction

function! LightlineCocStatus() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, "\uf057 " . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, "\uf071 " . info['warning'])
    endif
    return get(g:, 'coc_status', '') . ' ' . join(msgs, ' ')
endfunction

set noshowmode
" }}}
