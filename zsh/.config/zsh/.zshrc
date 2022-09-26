export EDITOR=${EDITOR:-nvim}
export HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=2000

# bindkey -v
bindkey "^[[H" "beginning-of-line"
bindkey "^[[F" "end-of-line"
bindkey "^[[2~" "overwrite-mode"
bindkey "^?" "backward-delete-char"
bindkey "^[[3~" "delete-char"
bindkey "^[[A" "up-line-or-history"
bindkey "^[[B" "down-line-or-history"
bindkey "^[[D" "backward-char"
bindkey "^[[C" "forward-char"
bindkey "^[[5~" "beginning-of-buffer-or-history"
bindkey "^[[6~" "end-of-buffer-or-history"
bindkey "^[[Z" "reverse-menu-complete"
bindkey "^[[1;5D" "backward-word"
bindkey "^[[1;5C" "forward-word"

autoload -Uz compinit
compinit

setopt autolist
setopt automenu
setopt autoparamkeys
setopt autopushd
setopt braceccl
setopt chaselinks
setopt completealiases
setopt extendedglob
setopt globdots
setopt histignorealldups
setopt histnostore
setopt histreduceblanks
setopt incappendhistory
setopt listtypes
setopt magicequalsubst
setopt multios
setopt noautoremoveslash
setopt nocheckjobs
setopt noclobber
setopt nocorrect
setopt nocorrectall
setopt nohup
setopt nolistbeep
setopt nolistpacked
setopt nomenucomplete
setopt pathdirs
setopt promptsubst
setopt pushdignoredups
setopt sharehistory

export PROMPT="%F{15}>%f "
export PROMPT_EOL_MARK=""

