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

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"


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
autoload -U compinit && compinit

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

if builtin command -v peco > /dev/null; then
    bindkey '^R' finder-history-selection
fi


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
function mkcd() {
    if [[ -d $1 ]]; then
        echo "$1 already exists!"
        cd $1
    else
        mkdir -p $1 && cd $1
    fi
}

function chpwd() {
    case ${OSTYPE} in
        darwin*)
            ls -ltrG
            ;;
        linux*)
            ls -ltr --color=auto
            ;;
    esac
}

function finder-history-selection() {
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
zle -N finder-history-selection

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
alias h='fc -lt '%F %T' 1'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'


################################
# Plugins
################################
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
