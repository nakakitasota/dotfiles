nnoremap s <Nop>

" ------------------------------------
" Window
" ------------------------------------
nnoremap ss :<C-u>split<CR><C-w>w
nnoremap sv :<C-u>vsplit<CR><C-w>w
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-
nnoremap se <C-w>=
nnoremap sx <C-w>x<C-w>w

" Terminal
tnoremap <ESC> <C-\><C-n>
if has('nvim')
    nnoremap st :<C-u>terminal<CR>
    tnoremap <C-w> <C-\><C-n><C-w>
else
    nnoremap st :<C-u>terminal++curwin<CR>
endif

" ------------------------------------
" Tab
" ------------------------------------
nnoremap te :<C-u>tabedit<CR>
nnoremap tp :<C-u>tabprev<CR>
nnoremap tn :<C-u>tabnext<CR>

" ------------------------------------
" Edit
" ------------------------------------
" Move line up/down
nnoremap <C-k> "zdd<Up>"zP
nnoremap <C-j> "zdd"zp
" multiple lines
autocmd VimEnter * vnoremap <C-k> "zx<Up>"zP`[V`]
vnoremap <C-j> "zx"zp`[V`]

" Use Emacs key bindings in insert mode
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <home>
imap <C-e> <End>
imap <C-h> <BS>
imap <C-d> <Del>
imap <C-y> <esc>pa

" Use Emacs key bindings in insert mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-k> <C-\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>
cnoremap <C-y> <C-r>"
