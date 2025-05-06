# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# language
export LANG=en_US.UTF-8

# PATH
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

#Android SDK
case ${OSTYPE} in
    darwin*)
        ANDROID_HOME=$HOME/Library/Android/sdk
        ;;
    linux*)
        ANDROID_HOME=$HOME/Android/Sdk
        ;;
esac

path=(
    $path
    $ANDROID_HOME(N-/)
    $ANDROID_HOME/emulator(N-/)
    $ANDROID_HOME/tools/(N-/)
    $ANDROID_HOME/platform-tools(N-/)
)

# fzf
export FZF_DEFAULT_OPTS="--height 40% --reverse --border sharp --preview-window sharp"

# editor
if builtin command -v nvim > /dev/null; then
    export EDITOR='nvim'
elif builtin command -v vim > /dev/null; then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi

# mise
eval "$(mise activate zsh)"


################################
# Options
################################
setopt ignoreeof
setopt no_flow_control
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt share_history
setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
cdpath=(~)


################################
# Colors
################################
autoload -Uz colors && colors

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'


################################
# Completion
################################
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin


################################
# Key bindings
################################
bindkey -e    # Emacs style

bindkey '^s' history-incremental-pattern-search-backward
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

if builtin command -v fzf > /dev/null; then
    bindkey '^R' finder-history-selection
fi

bindkey '^G' finder-repos


################################
# zmv
################################
autoload -Uz zmv
alias zmv='noglob zmv -W'


################################
# cdr
################################
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-file "$XDG_STATE_HOME/chpwd-recent-dirs"


################################
# word-style
################################
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-./;@"
zstyle ':zle:*' word-style unspecified


################################
# Prompt
################################
PROMPT="
%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color}(%*%) %~
%# "
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


################################
# Functions
################################
function cd() {
    if [ $# = 0 ]; then
        finder-cdr
    else
        builtin cd "$@"
    fi
}

function mkcd() {
    if [[ -d $1 ]]; then
        echo "$1 already exists!"
        cd $1
    else
        mkdir -p $1 && cd $1
    fi
}

function chpwd() {
    if builtin command -v eza > /dev/null; then
        eza --icons -l
    else
        case ${OSTYPE} in
            darwin*)
                ls -lG
                ;;
            linux*)
                ls -l --color=auto
                ;;
        esac
    fi
}

function finder-history-selection() {
    case ${OSTYPE} in
        darwin*)
            local hist=$(history -n 1 | tail -r | awk '!a[$0]++')
            ;;
        linux*)
            local hist=$(history -n 1 | tac | awk '!a[$0]++')
            ;;
    esac
    BUFFER=$(echo ${hist} | fzf --query="$LBUFFER" --prompt="History> " --no-sort)
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N finder-history-selection

function finder-cdr() {
    local lf=$(printf '\\\012_')
    lf=${lf%_}
    local target_dir=$(cdr -l \
        | sed -e 's/^[[:digit:]]*[[:blank:]]*//' -e "s:^~:$HOME:" -e "1s:^:${HOME}${lf}:" \
        | fzf --prompt="Directory> " --preview "eza --icons -a -T -L 1 {}")
    if [ -n "$target_dir" ]; then
        builtin cd $target_dir
    fi
}

function finder-repos() {
    local src=$(ghq list | fzf --prompt="Repository> " --preview "eza --icons -a -T -L 1 $(ghq root)/{}")
    if [ -n "$src" ]; then
        BUFFER="cd $(ghq root)/$src"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N finder-repos

function finder-android-emulator() {
    local src=$(emulator -list-avds | fzf --prompt="Emulator> ")
    if [ -n "$src" ]; then
        emulator @$src
    fi
}
alias fae='finder-android-emulator'

function colortest() {
    for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
}


################################
# Aliases
################################
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

alias so='source'
alias v='vim'
alias vi='vim'
alias vz='vim ~/.zshrc'
alias c='cdr'
alias h='fc -lt '%F %T' 1'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'

alias rgh='rg --hidden'

if builtin command -v eza > /dev/null; then
    alias ls='eza --icons'
    alias ll='eza --icons -l'
    alias la='eza --icons -al'
    alias lt='eza --icons --sort newest -l'
    alias lat='eza --icons --sort newest -al'
else
    case ${OSTYPE} in
        darwin*)
            alias ls='ls -G'
            alias ll='ls -lG'
            alias la='ls -laG'
            alias lt='ls -ltrG'
            alias lat='ls -altrG'
            ;;
        linux*)
            alias ls='ls --color=auto'
            alias ll='ls -l --color=auto'
            alias la='ls -la --color=auto'
            alias lt='ls -ltr --color=auto'
            alias lat='ls -altr --color=auto'
            ;;
    esac
fi


################################
# Plugins
################################
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

declare -A ZINIT
ZINIT[ZCOMPDUMP_PATH]="$XDG_STATE_HOME/zcompdump"

source "${ZINIT_HOME}/zinit.zsh"

zinit wait lucid blockf light-mode for \
    @'zsh-users/zsh-completions' \
    @'zsh-users/zsh-history-substring-search' \
    @'zsh-users/zsh-syntax-highlighting'

zinit ice depth"1"
zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions

zicompinit

# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
