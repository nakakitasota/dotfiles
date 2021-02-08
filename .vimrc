set encoding=utf-8

if &compatible
    set nocompatible
endif

" ------------------------------------
" 可視化文字表示テスト
" ------------------------------------
" 行末の半角スペース 
" 　全角スペース

" ------------------------------------
" Platform-dependent codes
" ------------------------------------
" if has("win64")
"     Windows
" endif

" ------------------------------------
" dein.vim Plugin manager
" ------------------------------------
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let g:rc_dir = expand('~/.vim/rc')
    let s:toml = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax enable

" ------------------------------------
" For Kaoriya build
" ------------------------------------
if has('kaoriya')
    let g:no_vimrc_example=0
    let g:vimrc_local_finish=1
    let g:gvimrc_local_finish=1

    " $VIM/plugins/kaoriya/autodate.vim
    let plugin_autodate_disable = 1
    " $VIM/plugins/kaoriya/cmdex.vim
    let plugin_cmdex_disable = 1
    " $VIM/plugins/kaoriya/dicwin.vim
    let plugin_dicwin_disable = 1
    " $VIMRUNTIME/plugin/format.vim
    let plugin_format_disable = 1
    " $VIM/plugins/kaoriya/hz_ja.vim
    let plugin_hz_ja_disable = 1
    " $VIM/plugins/kaoriya/scrnmode.vim
    let plugin_scrnmode_disable = 1
    " $VIM/plugins/kaoriya/verifyenc.vim
    let plugin_verifyenc_disable = 1
endif

" ------------------------------------
" General
" ------------------------------------
set number
set ruler
set cursorline
set smartindent
set title
set nowrap
set backspace=2
set statusline=%{expand('%:p:t')}\ %<[%{expand('%:p:h')}]%=\ %m%r%y%w[%{&fenc!=''?&fenc:&enc}][%{&ff}][%l,%c/%p]
set laststatus=2
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set background=dark
set ambiwidth=single
set ignorecase
set smartcase
set noswapfile
set nobackup
set noundofile
set belloff=all
" ハードタブの可視化
" set list listchars=tab:\¦\ 
set list listchars=tab:\>\-
syntax on
autocmd colorscheme * call SetUserColor()
function! SetUserColor()
    " ビジュアルモードのマーカー色を変更
    " hi Visual term=reverse cterm=reverse ctermfg=white ctermbg=black
    " hi Visual ctermbg=8
    " 全角スペースと行末半角スペースの可視化
    hi ExtraWhitespace ctermbg=1 guibg=Red
    match ExtraWhitespace / \+$\|　/
    " 背景色を無くす
    highlight Normal ctermbg=NONE
    highlight NonText ctermbg=NONE
    highlight SpecialKey ctermbg=NONE
    highlight EndOfBuffer ctermbg=NONE
    " コメント色
    " hi Comment cterm=NONE ctermfg=4 guifg=lightblue
    hi Comment cterm=NONE
endfunction

colorscheme night-owl

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

" 挿入モード時ステータスラインの色を変える
" let g:hi_insert = 'hi StatusLine gui=None guifg=Black guibg=Yellow cterm=None ctermfg=White ctermbg=darkyellow'

" if has('syntax')
"     augroup InsertHook
"         autocmd!
"         autocmd InsertEnter * call s:StatusLine('Enter')
"         autocmd InsertLeave * call s:StatusLine('Leave')
"     augroup END
" endif
"
" let s:slhlcmd = ''
" function! s:StatusLine(mode)
"     if a:mode == 'Enter'
"         silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"         silent exec g:hi_insert
"     else
"         highlight clear StatusLine
"         silent exec s:slhlcmd
"     endif
" endfunction
"
" function! s:GetHighlight(hi)
"     redir => hl
"     exec 'highlight '.a:hi
"     redir END
"     let hl = substitute(hl, '[\r\n]', '', 'g')
"     let hl = substitute(hl, 'xxx', '', '')
"     return hl
" endfunction

" ------------------------------------
" ファイルタイプ別の設定
" ------------------------------------
" プレーンテキストの時のみ折り返しを有効にする
au FileType text setlocal wrap

" ------------------------------------
" vim-indent-guides
" ------------------------------------
" let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_start_level=1
" let g:indent_guides_auto_colors=0
" let g:indent_guides_guide_size=1
" 奇数インデントのカラー
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#262626 ctermbg=gray
" 偶数インデントのカラー
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray

" ------------------------------------
" indentLine
" ------------------------------------
let g:indentLine_faster = 1

" ------------------------------------
"  emmet-vim <Tab> (Insert)
" ------------------------------------
let g:user_emmet_leader_key=v:null
autocmd FileType html,css,php imap <buffer><expr><tab>
    \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" :
    \ "\<tab>"

" ------------------------------------
" NERDTreeToggle <Ctrl-N>
" ------------------------------------
map <C-n> :NERDTreeToggle<CR>
" 起動時にブックマークを表示する
let g:NERDTreeShowBookmarks=1

" ------------------------------------
" Unite.vim <Space+...>
" ------------------------------------
" ヒストリー/ヤンク機能を有効化
let g:unite_source_history_yank_enable =1
" prefix keyの設定
nmap <Space> [unite]

" スペースキーとaキーでカレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" スペースキーとfキーでバッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
" スペースキーとdキーで最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
" スペースキーとbキーでバッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
" スペースキーとrキーでレジストリを表示
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
" スペースキーとtキーでタブを表示
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
" スペースキーとhキーでヒストリ/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
" スペースキーとoキーでoutline
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
" スペースキーとENTERキーでfile_rec:!
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
" unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    " ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}

" ------------------------------------
" neocomplete・neosnippet
" ------------------------------------
" Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase有効化:大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" 3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 3
" 区切り文字まで補完する
" let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
" バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
" 補完候補が表示されている場合は確定。そうでない場合は改行
inoremap <expr><CR>  pumvisible() ? neocomplete#close_popup() : "<CR>"

" スニペットの展開,ジャンプをCtrl-Kにマップ
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Ctrl-Lで共通部分を補完
inoremap <expr><C-l> neocomplete#complete_common_string()

" Enterで補完候補の確定,スニペットの展開
" imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" Tabで補完候補の選択,スニペット内のジャンプ
" imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

" ------------------------------------
" vim-surround
" ------------------------------------
let g:surround_{char2nr("「")} = "「 \r 」"
let g:surround_{char2nr("」")} = "「\r」"
let g:surround_{char2nr("【")} = "【 \r 】"
let g:surround_{char2nr("】")} = "【\r】"
let g:surround_{char2nr("（")} = "（ \r ）"
let g:surround_{char2nr("）")} = "（\r）"
let g:surround_{char2nr("＜")} = "＜ \r ＞"
let g:surround_{char2nr("＞")} = "＜\r＞"
let g:surround_{char2nr("｛")} = "｛ \r ｝"
let g:surround_{char2nr("｝")} = "｛\r｝"

" ------------------------------------
" tcomment <Ctrl-Minus>
" ------------------------------------
" コメント前にスペースを入れたくない言語
" au FileType vim,zsh,css,php,cs let g:tcomment#options = {'whitespace': 'no'}

" ------------------------------------
" vim-airline
" ------------------------------------
let g:airline_theme = 'papercolor'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

