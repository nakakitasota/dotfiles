" ------------------------------------
" Tab
" ------------------------------------
nnoremap te :<C-u>tabedit<CR>
nnoremap tp :<C-u>tabprev<CR>
nnoremap tn :<C-u>tabnext<CR>

" ------------------------------------
" Edit
" ------------------------------------
" ノーマルモード時Ctrl-K, Ctrl-Jで行を移動
nnoremap <C-k> "zdd<Up>"zP
nnoremap <C-j> "zdd"zp
" 複数行
autocmd VimEnter * vnoremap <C-k> "zx<Up>"zP`[V`]
vnoremap <C-j> "zx"zp`[V`]

" 挿入モード時Emacsキーバインド
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <home>
imap <C-e> <End>
imap <C-h> <BS>
imap <C-d> <Del>
imap <C-y> <esc>pa
