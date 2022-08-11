if [[ -z "$PS1" ]] then
    return
fi

function setup_vars() {
    export EDITOR=${EDITOR:-nvim}
    export HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
    export HISTSIZE=1000
    export SAVEHIST=2000
}

function bind_keys() {
    bindkey -v
    bindkey "^[[H" beginning-of-line
    bindkey "^[[F" end-of-line
    bindkey "^[[2~" overwrite-mode
    bindkey "^?" backward-delete-char
    bindkey "^[[3~" delete-char
    bindkey "^[[A" up-line-or-history
    bindkey "^[[B" down-line-or-history
    bindkey "^[[D" backward-char
    bindkey "^[[C" forward-char
    bindkey "^[[5~" beginning-of-buffer-or-history
    bindkey "^[[6~" end-of-buffer-or-history
    bindkey "^[[Z" reverse-menu-complete
    bindkey "^[[1;5D" backward-word
    bindkey "^[[1;5C" forward-word
}

function setup_opts() {
    setopt AUTO_LIST
    setopt AUTO_MENU
    setopt AUTO_PARAM_KEYS
    setopt AUTO_PUSHD
    setopt BRACE_CCL
    setopt CHASE_LINKS
    setopt COMPLETE_ALIASES
    setopt CORRECT_ALL
    setopt EXTENDED_GLOB
    setopt GLOB_DOTS
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_NO_STORE
    setopt HIST_REDUCE_BLANKS
    setopt INC_APPEND_HISTORY
    setopt LIST_PACKED
    setopt LIST_TYPES
    setopt MAGIC_EQUAL_SUBST
    setopt MULTIOS
    setopt NO_AUTO_REMOVE_SLASH
    setopt NO_CHECK_JOBS
    setopt NO_CLOBBER
    setopt NO_CORRECT
    setopt NO_CORRECT_ALL
    setopt NO_HUP
    setopt NO_LIST_BEEP
    setopt NO_MENU_COMPLETE
    setopt PATH_DIRS
    setopt PROMPT_SUBST
    setopt PUSHD_IGNORE_DUPS
    setopt SHARE_HISTORY
}

function on_before_command() {
    print -P "%n@%m %F{#3fdcee}%~%f"
}

function setup_prompt() {
    add-zsh-hook precmd on_before_command
    export PROMPT="%F{#b043d1}%f "
}

function setup_completion() {
    zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}"
}

function setup_autosuggestions() {
    source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
}

function setup_syntax_highlighting() {
    source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}

autoload -Uz add-zsh-hook

bind_keys
setup_vars
setup_opts
setup_prompt
setup_completion
setup_autosuggestions
# setup_syntax_highlighting

