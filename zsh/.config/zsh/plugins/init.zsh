plugins="$ZDOTDIR/plugins"
for plugin in ${plugins}/*/init.zsh; do
    if [[ -f $plugin ]]; then
        source $plugin
    fi
done

