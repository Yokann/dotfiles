# - - - - - - - - - - - - - - - - - - - -
# Custom loading configuration
# - - - - - - - - - - - - - - - - - - - -
if [ -z "$DOTFILES_PATH" ]; then
    echo "DOTFILES_PATH is not set. Please set it to the path of your dotfiles repository."
    return
fi
BASE_CONF_PATH=$DOTFILES_PATH/config/zsh
CUSTOM_CONF_PATH=$HOME/.dotfiles-custom

# Load the shell dotfiles, and then some:
# * ~/.dotfiles-custom can be used for other settings you don’t want to commit.
for file in $BASE_CONF_PATH/definitions/{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

for file in $CUSTOM_CONF_PATH/zsh/{exports,aliases,functions,pre_zshrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

autoload -U colors && colors    # Load Colors.
autoload -Uz url-quote-magic

for file in $BASE_CONF_PATH/core/*; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load custom completions, execute once or after updates
# [[ -d $CUSTOM_CONF_PATH/completions ]] && zinit creinstall $CUSTOM_CONF_PATH/completions
# [[ -d $ZSH_CACHE_DIR/completions ]] && zinit creinstall $ZSH_CACHE_DIR/completions

# Custom config
[[ -f $CUSTOM_CONF_PATH/zsh/post_zshrc ]] && source $CUSTOM_CONF_PATH/zsh/post_zshrc

# - - - - - - - - - - - - - - - - - - - -
# Theme / Prompt Customization
# - - - - - - - - - - - - - - - - - - - -
eval "$(mise activate zsh --shims)"
eval "$(starship init zsh)"
# Keep Emacs style shell command Ctrl+A etc
bindkey -e

