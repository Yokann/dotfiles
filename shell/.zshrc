# Enable Powerlevel10k instant prompt. Should stay close to the top of `~/.zshrc`.
# Initialization code that may require console input ( password prompts, [y/n]
# confirmations, etc. ) must go above this block, everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# - - - - - - - - - - - - - - - - - - - -
# Custom loading configuration
# - - - - - - - - - - - - - - - - - - - -

# Load the shell dotfiles, and then some:
# * ~/.dotfiles-custom can be used for other settings you don’t want to commit.
for file in ~/.dotfiles/shell/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

for file in ~/.dotfiles-custom/shell/.{exports,aliases,functions,zshrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Extra paths
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.dotfiles/bin:$PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH

# Custom config
source $HOME/.zshrc_custom

# - - - - - - - - - - - - - - - - - - - -
# ZSH Settings
# - - - - - - - - - - - - - - - - - - - -

autoload -U colors && colors    # Load Colors.
autoload -Uz url-quote-magic

# Completion Options.
setopt complete_in_word         # Complete From Both Ends Of A Word.
setopt always_to_end            # Move Cursor To The End Of A Completed Word.
setopt path_dirs                # Perform Path Search Even On Command Names With Slashes.
setopt auto_menu                # Show Completion Menu On A Successive Tab Press.
setopt auto_list                # Automatically List Choices On Ambiguous Completion.
setopt auto_param_slash         # If Completed Parameter Is A Directory, Add A Trailing Slash.
setopt no_complete_aliases

#setopt correct                  # Turn On Corrections
unsetopt menu_complete           # Do Not Autoselect The First Completion Entry.

# History.
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=5000
setopt appendhistory notify
unsetopt beep nomatch

setopt bang_hist                # Treat The '!' Character Specially During Expansion.
setopt inc_append_history       # Write To The History File Immediately, Not When The Shell Exits.
setopt share_history            # Share History Between All Sessions.
setopt hist_expire_dups_first   # Expire A Duplicate Event First When Trimming History.
setopt hist_ignore_dups         # Do Not Record An Event That Was Just Recorded Again.
setopt hist_ignore_all_dups     # Delete An Old Recorded Event If A New Event Is A Duplicate.
setopt hist_find_no_dups        # Do Not Display A Previously Found Event.
setopt hist_ignore_space        # Do Not Record An Event Starting With A Space.
setopt hist_save_no_dups        # Do Not Write A Duplicate Event To The History File.
setopt hist_verify              # Do Not Execute Immediately Upon History Expansion.
setopt extended_history         # Show Timestamp In History.

setopt promptsubst # Used by many themes

#zstyle ':completion:*' selectmpt ''
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
#zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
#zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
#zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
#zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
#zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

zstyle ':fzf-tab:*' continuous-trigger '²'

# - - - - - - - - - - - - - - - - - - - -
# Zinit
# - - - - - - - - - - - - - - - - - - - -

typeset -g ZINIT_PATH=${ZDOTDIR:-$HOME/.local/share}/zinit

if [ ! -f $ZINIT_PATH/zinit.zsh ] && ((${+commands[git]})); then
    __zinit_just_installed=1
    mkdir -p $ZINIT_PATH && chmod g-rwX "$ZINIT_PATH" && \
    git clone --depth=1 https://github.com/zdharma-continuum/zinit.git $ZINIT_PATH
fi

if [ -f $ZINIT_PATH/zinit.zsh ]; then
    declare -A ZINIT

    ZINIT[HOME_DIR]="$ZINIT_PATH"

    source $ZINIT_PATH/zinit.zsh

    if [ -z "$skip_global_compinit" ]; then
      autoload -Uz _zinit
      (( ${+_comps} )) && _comps[zinit]=_zinit
    fi

    [ -n "$__zinit_just_installed" ] && \
        zinit self-update

    unset ZINIT_PATH # Use ZINIT[HOME_DIR] from now on

    [ ${${(s:.:)ZSH_VERSION}[1]} -ge 5 ] && [ ${${(s:.:)ZSH_VERSION}[2]} -gt 2 ] && \
      MY_ZINIT_USE_TURBO=true
fi

# - - - - - - - - - - - - - - - - - - - -
# Plugins
# - - - - - - - - - - - - - - - - - - - -

_my_zsh_custom_plugins=(    
#    b4b4r07/enhancd
     Aloxaf/fzf-tab
     joshskidmore/zsh-fzf-history-search
)

# Need to be load before everything else 
#zinit load marlonrichert/zsh-autocomplete

# These plugins provide many aliases - atload''
zinit wait lucid for \
        OMZL::git.zsh \
    atload"unalias grv" \
        OMZP::git
   
# OMZ plugins
zinit wait lucid for \
      OMZP::docker-compose \
      OMZP::aws \
      OMZP::archlinux \
   atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
      OMZP::colored-man-pages\
   as"completion" \
      OMZP::docker/_docker \
      OMZ::plugins/composer/composer.plugin.zsh \
      OMZ::plugins/docker-compose/docker-compose.plugin.zsh 

#typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=true
#typeset -g ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

__zinit_plugin_loaded_callback() {
    if [[ "$ZINIT[CUR_PLUGIN]" == "zsh-autosuggestions" ]]; then
        ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS[@]/forward-char}")
        ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=forward-char
    elif [[ "$ZINIT[CUR_PLUGIN]" == "zsh-history-substring-search" ]]; then
        bindkey "\ek" history-substring-search-up
        bindkey "\ej" history-substring-search-down
    fi
}

zinit wait lucid depth=1  \
    atload='__zinit_plugin_loaded_callback' \
    for ${_my_zsh_custom_plugins[@]}

# - - - - - - - - - - - - - - - - - - - -
# Theme / Prompt Customization
# - - - - - - - - - - - - - - - - - - - -
eval "$(starship init zsh)"
# Keep Emacs style shell command Ctrl+A etc
bindkey -e


### End of Zinit's installer chunk
