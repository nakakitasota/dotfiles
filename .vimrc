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
set fileformats=unix,dos,mac
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
set list listchars=tab:\>\-
syntax enable
autocmd colorscheme * call SetUserColor()
function! SetUserColor()
    " 背景色を無くす
    highlight Normal ctermbg=NONE
    highlight NonText ctermbg=NONE
    highlight SpecialKey ctermbg=NONE
    highlight EndOfBuffer ctermbg=NONE
    " コメント色
    hi Comment cterm=NONE
    " 補完ウィンドウの色
    hi Pmenu ctermbg=236 ctermfg=251 guibg=#3d425b guifg=#c6c8d1
    hi PmenuSbar ctermbg=236 ctermfg=NONE guibg=#3d425b guifg=NONE
    hi PmenuSel ctermbg=240 ctermfg=255 guibg=#5b6389 guifg=#eff0f4
    hi PmenuThumb ctermbg=251 ctermfg=NONE guibg=#c6c8d1 guifg=NONE
endfunction

colorscheme night-owl

" ------------------------------------
" ファイルタイプ別の設定
" ------------------------------------
" プレーンテキストの時のみ折り返しを有効にする
au FileType text setlocal wrap

" ------------------------------------
" Imports
" ------------------------------------
source ~/.vim/rc/keymaps.rc.vim
