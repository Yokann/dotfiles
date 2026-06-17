# - - - - - - - - - - - - - - - - - - - -
# Custom loading configuration
# - - - - - - - - - - - - - - - - - - - -
if [ -z "$DOTFILES_PATH" ]; then
    echo "DOTFILES_PATH is not set. Please set it to the path of your dotfiles repository."
    return
fi
export DOTFILES_CUSTOM_PATH=${DOTFILES_CUSTOM_PATH:-"$HOME/.dotfiles-custom"}

# Load the shell dotfiles, and then some:
# * ~/.dotfiles-custom can be used for other settings you don’t want to commit.
for file in $DOTFILES_PATH/config/zsh/definitions/{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

for file in $DOTFILES_CUSTOM_PATH/zsh/{exports,aliases,functions,pre_zshrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

autoload -U colors && colors    # Load Colors.
autoload -Uz url-quote-magic

for file in $DOTFILES_PATH/config/zsh/core/*; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load custom completions, execute once or after updates
DOTFILES_STATE_PATH="$HOME/.local/state/dotfiles"
if [[ ! -f "$DOTFILES_STATE_PATH/init_completion" ]]; then
    [[ -d $DOTFILES_CUSTOM_PATH/completions ]] && zinit creinstall $DOTFILES_CUSTOM_PATH/completions
    [[ -d $ZSH_CACHE_DIR/completions ]] && zinit creinstall $ZSH_CACHE_DIR/completions
    touch $DOTFILES_STATE_PATH/init_completion
fi

# Custom config
[[ -f $DOTFILES_CUSTOM_PATH/zsh/post_zshrc ]] && source $DOTFILES_CUSTOM_PATH/zsh/post_zshrc

# - - - - - - - - - - - - - - - - - - - -
# Theme / Prompt Customization
# - - - - - - - - - - - - - - - - - - - -
eval "$(mise activate zsh --shims)"
eval "$(starship init zsh)"
# Keep Emacs style shell command Ctrl+A etc
bindkey -e

