# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#Path
typeset -U path PATH
case ${OSTYPE} in
    darwin*)
        path=(
            /opt/homebrew/bin(N-/)
            /usr/local/bin(N-/)
            $path
        )
        ;;
esac

#nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

#Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF

#英語を使用
export LANG=en_US.UTF-8

#色を使用
autoload -Uz colors
colors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

#補完機能を使用する
autoload -U compinit
compinit
zstyle ':completion::complete:*' use-cache true
#zstyle ':completion:*:default' menu select true
zstyle ':completion:*:default' menu select=1

#大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#補完でカラーを使用する
autoload colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

#kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

#コマンドにsudoを付けても補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin

#Emacsキーバインド
bindkey -e

#補完の選択のみVimキーバインドにする
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

#他のターミナルとヒストリーを共有
setopt share_history

#ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

#cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

#自動でpushdを実行
setopt auto_pushd

#pushdから重複を削除
setopt pushd_ignore_dups

#コマンドミスを修正
setopt correct


#グローバルエイリアス
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'


#エイリアス
case ${OSTYPE} in
    darwin*)
        alias ls='ls -G'
        alias lst='ls -ltrG'
        alias l='ls -ltrG'
        alias la='ls -laG'
        alias ll='ls -lG'
        ;;
    linux*)
        alias ls='ls --color=auto'
        alias lst='ls -ltr --color=auto'
        alias l='ls -ltr --color=auto'
        alias la='ls -la --color=auto'
        alias ll='ls -l --color=auto'
        ;;
esac
alias so='source'
alias v='vim'
alias vi='vim'
alias vz='vim ~/.zshrc'
alias c='cdr'
#historyに日付を表示
alias h='fc -lt '%F %T' 1'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'

#cdの後にlsを実行
chpwd() {
    case ${OSTYPE} in
        darwin*)
            ls -ltrG
            ;;
        linux*)
            ls -ltr --color=auto
            ;;
    esac
}

#どこからでも参照できるディレクトリパス
cdpath=(~)

#区切り文字の設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-./;@"
zstyle ':zle:*' word-style unspecified

#Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

#プロンプトを2行で表示、時刻を表示
PROMPT="
%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color}(%*%) %~
%# "

#補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

#補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#Ctrl+sでヒストリーのインクリメンタルサーチ
bindkey '^s' history-incremental-pattern-search-backward

#コマンドを途中まで入力後、historyから絞り込み
#例 ls まで打ってCtrl+pでlsコマンドをさかのぼる、Ctrl+bで逆順
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end

#cdrコマンドを有効 ログアウトしても有効なディレクトリ履歴
#cdr タブでリストを表示
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

#cdrコマンドで履歴にないディレクトリにも移動可能に
zstyle ":chpwd:*" recent-dirs-default true

#複数ファイルのmv 例)zmv *.txt *.txt.bk
autoload -Uz zmv
alias zmv='noglob zmv -W'

#mkdirとcdを同時実行
function mkcd() {
    if [[ -d $1 ]]; then
        echo "$1 already exists!"
        cd $1
    else
        mkdir -p $1 && cd $1
    fi
}

#色見本
function colortest() {
    for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
}

#git設定
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

#ヒストリーサーチにpecoを使う
function peco-history-selection() {
    case ${OSTYPE} in
        darwin*)
            BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
            ;;
        linux*)
            BUFFER=`\\history -n 1 | tac | awk '!a[$0]++' | peco`
            ;;
    esac
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection

#Ctrl-Rでpeco起動
if builtin command -v peco > /dev/null; then
    bindkey '^R' peco-history-selection
fi

#zplug設定
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "b4b4r07/enhancd", use:"init.sh"
zplug "romkatv/powerlevel10k", as:theme, depth:1

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
