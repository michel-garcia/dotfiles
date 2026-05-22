if status is-interactive
    eval "$(zoxide init --cmd cd fish)"
end

set -gx EDITOR "nvim"
set -gx ANDROID_HOME "$HOME/Android/Sdk"

fish_add_path --append "$HOME/.local/bin"
fish_add_path --append "$HOME/.config/composer/vendor/bin"

fish_vi_key_bindings

function fish_mode_prompt
end
