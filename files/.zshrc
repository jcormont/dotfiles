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

# Set history behavior with up/down keys
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# Aliases
alias e=nvim
alias r="tmux rename-session $argv"
alias g="git status -s -b $argv"
alias gg="git log --graph --decorate --all --date-order --pretty='%C(green)%h%C(reset) %C(italic blue)%ar%C(reset)%C(yellow)%d%C(reset) - %s' $argv"
alias bastion="tmux new-session -d -s bastion ./.scripts/bastion.sh"
alias backup="cd;./.scripts/pack.sh"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

