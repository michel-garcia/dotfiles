function fish_prompt
    set -l last_status $status
    set_color --bold green
    printf "%s" (whoami)
    set_color normal
    set_color --bold
    printf " in "
    set_color normal
    set_color --bold blue
    printf "%s" (prompt_pwd)
    set_color normal
    set -l vcs (string trim -c " ()" (fish_vcs_prompt))
    if test -n "$vcs"
        set_color --bold
        printf " on "
        set_color --bold yellow
        printf " %s" "$vcs"
        set_color normal
    end
    echo
    if test $last_status -eq 0
        set_color cyan
    else
        set_color red
    end
    printf "\$ "
    set_color normal
end
