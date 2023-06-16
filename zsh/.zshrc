export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="awesomepanda"

# Editor Config
export VISUAL=nvim
export EDITOR="$VISUAL"

# Plugins
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

zinit light-mode for \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-history-substring-search \
    zsh-users/zsh-completions 

# ASDF
. "$HOME/.asdf/asdf.sh"
. $HOME/.asdf/completions/asdf.bash

### Aliases
# Configs
alias btc="nvim ~/.config/better-vim"
alias gc="nvim ~/.gitconfig"
alias tma="tmux attach"
alias tmc="nvim ~/.tmux.conf.local"
alias tmk="tmux kill-server"
alias tmu="tmux source-file ~/.tmux.conf.local"
alias wtc="nvim ~/.wezterm.lua"
alias zc="nvim ~/.zshrc"
alias zu="source ~/.zshrc"

# Actions
alias c="clear"
alias e="exit"
alias q="quit"
alias u="sudo pacman -Syu"

# Applications
alias g="git"
alias tm="tmux"
alias v="nvim"

# Projects
alias y="yarn"
alias ya="yarn add --exact"
alias yad="yarn add --dev --exact"
alias yb="y build"
alias yd="y dev"
alias yl="y lint"
alias ylf="y lint:fix"
alias yrb="y rescript:build"
alias yrb="y rescript:clean"
alias yrd="y rescript:dev"
alias ys="y start"
alias ysb="y storybook"
alias yt="y test"
alias ytc="y type-check"
alias ytcw="y type-check --watch"
alias ytw="y test:watch"

# Custom Functions
function mktouch () {
  for p in $@; do
    mkdir -p $(dirname "$p")
  done

  touch $@
}
