#!/bin/bash
set -euo pipefail

# Script for setting up dotfiles and development tools
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly OMZ_CUSTOM="${HOME}/.oh-my-zsh/custom"

# Error handling
trap 'echo "Error: Script failed at line $LINENO" >&2; exit 1' ERR

# Install spaceship prompt
install_spaceship_prompt() {
  echo "Installing spaceship prompt..."
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git \
    "${OMZ_CUSTOM}/themes/spaceship-prompt" --depth=1
}

# Install ZSH syntax highlighting
install_zsh_syntax_highlighting() {
  echo "Installing ZSH syntax highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${OMZ_CUSTOM}/plugins/zsh-syntax-highlighting"
}

# Update system dependencies
install_dependencies() {
  if command -v apt-get &> /dev/null; then
    echo "Updating system dependencies..."
    sudo apt-get update
    sudo apt-get install -y bat direnv
  fi
}

# Install starship prompt
install_starship_prompt() {
  echo "Installing starship prompt..."
  local starship_installer="install_starship.sh"
  curl -sS https://starship.rs/install.sh > "${starship_installer}"
  sh "${starship_installer}" --yes
  rm -f "${starship_installer}"
}

# Create symlinks
create_symlinks() {
  echo "Creating symlinks..."
  if [[ -f "${SCRIPT_DIR}/createSymLinks.sh" ]]; then
    bash "${SCRIPT_DIR}/createSymLinks.sh"
  else
    echo "Error: createSymLinks.sh not found" >&2
    exit 1
  fi
}

# Main execution
main() {
  echo "Starting dotfiles installation..."
  install_spaceship_prompt
  install_zsh_syntax_highlighting
  install_dependencies
  install_starship_prompt
  create_symlinks
  echo "Installation complete!"
}

main "$@"
