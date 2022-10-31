autoload -Uz compinit && compinit

function git_prompt {
    local statc="%F{004}" # assume clean: neutral blue color
    local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

    if [ -n "$bname" ]; then
        local rs="$(git status --porcelain -b)"
        if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty: yellow
            statc="%F{003}"
        elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged: purple
            statc="%F{013}"
        elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind: red
            statc="%F{001}"
        elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead; green
            statc="%F{002}"
        fi

        echo -n " $statc$bname%{\e[0m%} ❱"
    fi
}

# Set custom prompt
setopt prompt_subst
PROMPT='%F{014}%1~ ❱$(git_prompt)%f '

# Set default editor
export EDITOR='nvim'

# Enable history
HISTFILE=~/.zsh-history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$key[Up]" up-line-or-beginning-search
bindkey "$key[Down]" down-line-or-beginning-search

# Aliases (nvim, tmux, git, exa, bat)
alias e=nvim
alias t="tmux a || tmux new-session -s main"
alias r="tmux rename-session $argv"
alias g="git status -s -b $argv"
alias gg="git log --graph --decorate --all --date-order --pretty='%C(green)%h%C(reset) %C(italic blue)%ar%C(reset)%C(yellow)%d%C(reset) - %s' $argv"
alias ls="exa --long --header"
alias tree="exa --long --tree"
alias b="batcat"

# Script aliases (from .scripts folder)
alias bastion="cd;tmux new-session -d -s bastion ./.scripts/bastion.sh"
alias backup="cd;./.scripts/pack.sh"

# Set tab size to 2 in terminal and less command (for git)
tabs -2
export LESS="Rx2"
export TABSIZE=2

# ZSH syntax highlighting (installed separately)
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load NVM (installed separately)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
