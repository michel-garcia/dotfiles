HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_CACHE_HOME/zsh/history"
mkdir -p "$XDG_CACHE_HOME/zsh"

setopt ALWAYS_TO_END
setopt AUTO_CD
setopt AUTO_PUSHD
setopt COMPLETE_IN_WORD
setopt EXTENDED_HISTORY
setopt GLOB_DOTS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt LIST_ROWS_FIRST
setopt NO_HUP
setopt PUSHD_SILENT
setopt PROMPT_SUBST
setopt SHARE_HISTORY
setopt TRANSIENT_RPROMPT

autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

autoload -Uz vcs_info
zstyle ":vcs_info:git:*" formats "%b"

bindkey -v
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

source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_DIRS_BLACKLIST=("/mnt")
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

precmd() {
    vcs_info
    print -Pn "%B%F{green}%n%f%b"
    print -Pn "%B in %F{blue}%~%f%b"
    if [[ ! -z ${vcs_info_msg_0_} ]]; then
        print -Pn "%B on %F{yellow}שׂ ${vcs_info_msg_0_}%f%b"
    fi
    print
}
PROMPT="%B%(?.%F{cyan}.%F{red})$%f%b "
PROMPT_EOL_MARK=""

