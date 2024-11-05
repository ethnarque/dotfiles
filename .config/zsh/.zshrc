# Default to Vim bindings, regardless of editor string
bindkey -v

# History
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_SPACE

HIST_SIZE=10000
SAVE_HIST=10000
HISTFILE="$HOME/Library/Caches/zsh_history"

# Homebrew
if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
    fpath+=/opt/homebrew/share/zsh/site-functions
fi

# Plugins
export ZSH_PLUGIN_DIR=$ZDOTDIR/plugins

if [[ -d "$ZSH_PLUGIN_DIR" ]]; then
    mkdir -p $ZSH_PLUGIN_DIR
fi

## typewritten
if [[ -d "$ZSH_PLUGIN_DIR/typewritten" ]]; then
    fpath+=$ZSH_PLUGIN_DIR/typewritten

    # Options
    TYPEWRITTEN_CURSOR=terminal

    autoload -U promptinit; promptinit
    prompt typewritten
fi

## zsh-history-substring-search
if [[ -d "$ZSH_PLUGIN_DIR/zsh-history-substring-search" ]]; then
    source "$ZSH_PLUGIN_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh"

    bindkey '^[[A' history-substring-search-up # or '\eOA'
    bindkey '^[[B' history-substring-search-down # or '\eOB'
    HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
fi

# LaTeX
#if [[ -d /Library/TeX/texbin ]]; then
    export PATH="/Library/TeX/texbin:$PATH"
#fi
#
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/pml/.opam/opam-init/init.zsh' ]] || source '/Users/pml/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration


# Autoload and cache for 24h for fast startup
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24) ]]; then
    compinit
else
    compinit -C
fi

eval "$(direnv hook zsh)"

export XDG_REPOS_DIR="$HOME/Documents/Repositories"

hash -d repos="$XDG_REPOS_DIR"
hash -d notes="$HOME/Documents/Notes"

function config() {
    echo "Hello, World! $1"
}

alias dot="$(which git) --git-dir=$XDG_REPOS_DIR/dotfiles --work-tree=$HOME"
