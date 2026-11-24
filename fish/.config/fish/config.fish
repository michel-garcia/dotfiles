set -gx EDITOR "nvim"
set -gx ANDROID_HOME "$HOME/Android/Sdk"

set -g fish_greeting ""

function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert \cf accept-autosuggestion
end

function fish_mode_prompt
end

fish_add_path -g "$HOME/.local/bin"
fish_add_path -g "$HOME/.local/share/bob/nvim-bin"
fish_add_path -g "$HOME/.config/composer/vendor/bin"
fish_add_path -g "$HOME/.cargo/bin"
fish_add_path -g "$HOME/go/bin"

if status is-interactive
    if command -q zoxide
        zoxide init --cmd cd fish | source
    end
end
