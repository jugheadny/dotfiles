# useful only for Mac OS Silicon M1, 
# still working but useless for the other platforms
docker() {
  if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
     /usr/local/bin/docker "$1" --platform linux/amd64 "${@:2}"
  else
     /usr/local/bin/docker "$@"
  fi
}

[[ -f ~/$HOME/dotfiles/aliases.zsh ]] && source ~/$HOME/dotfiles/aliases
[[ -f ~/$HOME/dotfiles/functions.zsh ]] && source ~/$HOME/dotfiles/functions
[[ -f ~/$HOME/dotfiles/starship.zsh ]] && source ~/$HOME/dotfiles/starship
[[ -f ~/$HOME/dotfiles/nvm.zsh ]] && source ~/$HOME/dotfiles/nvm
[[ -f ~/$HOME/dotfiles/wsl2fix.zsh ]] && source ~/$HOME/dotfiles/wsl2fix
[[ -f ~/$HOME/dotfiles/goto.zsh ]] && source ~/$HOME/dotfiles/goto

# Load Starship
eval "$(starship init zsh)"

# Load Direnv
eval "$(direnv hook zsh)"