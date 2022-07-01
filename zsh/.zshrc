# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="avit"

# Default configs
DISABLE_UPDATE_PROMPT="true"
DISABLE_AUTO_TITLE="true"

# Plugins
plugins=(git zsh-nvm)
source $ZSH/oh-my-zsh.sh

### Added by Zinit"s installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Zinit plugins
zinit for \
	light-mode zsh-users/zsh-autosuggestions \
	light-mode zsh-users/zsh-completions \
	light-mode zdharma-continuum/fast-syntax-highlighting \
	light-mode bobthecow/git-flow-completion

# Powerlevel10k
zinit ice depth=1;
zinit light romkatv/powerlevel10k

### Aliases
# Editors
alias vim="lvim"
alias vi="vim"

# ZSH Config
alias zsh-config="nvim ~/.zshrc"
alias zsh-update="source ~/.zshrc"
alias zc="zsh-config"
alias zu="zsh-update"

# Projects
alias g="git"
alias y="yarn"
alias yd="y dev"
alias yl="y lint"
alias yg="y generate"
alias ylf="y lint:fix"
alias ytc="y type-check"
alias ytw="y type-check:watch"

# Terminal
alias l="ls -lah --group-directories-first"
alias c="clear"
alias q="exit"

# System
alias update="flatpak update -y && sudo apt update && sudo apt upgrade -y && sudo snap refresh"
alias update-first="flatpak update -y && sudo snap refresh"
alias clean="sudo apt autoclean && sudo apt autoremove"
alias u="update"
alias uf="update-first"
alias cl="clean"

# Directories
alias mmdc="cd ~/development/murimessias"

# Other settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export TERM="xterm-256color"
export VISUAL="lvim"
export EDITOR=$VISUAL

# My $PATH configs
export PATH=node_modules/.bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH

# Add Yarn globals on $PATH
export PATH=$PATH:$(yarn global bin)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
