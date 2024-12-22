" hook_add {{{
let g:lightline = {
    \ 'colorscheme': 'nightfly',
    \ 'mode_map': {'c': 'NORMAL'},
    \ 'active': {
    \     'left': [
    \         ['mode', 'paste'],
    \         ['gitbranch', 'readonly', 'filename'],
    \     ],
    \     'right': [
    \         ['lineinfo', 'syntastic'],
    \         ['percent'],
    \         ['charcode', 'fileformat', 'fileencoding', 'filetype'],
    \         ['lsp_status', 'lsp_errors', 'lsp_warnings', 'lsp_hints', 'lsp_info', 'lsp_ok'],
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

set noshowmode
" }}}
