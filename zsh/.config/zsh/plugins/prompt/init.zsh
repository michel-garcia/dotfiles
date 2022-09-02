function setup() {
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd on_before_command
    parts=(
        $(foreground 6 "->")
    )
    export PROMPT=$(join " " "${parts[@]}")
    export PROMPT_EOL_MARK=""
}

function on_before_command() {
    print -P $(foreground 3 "%~")
}

function join() {
    output=""
    for i in ${2[@]}; do
        output="${output}${i}$1"
    done
    print -P $output
}

function foreground() {
    print -P "%F{$1}$2%f"
}

function background() {
    print -P "%K{$1}$2%k"
}

setup

