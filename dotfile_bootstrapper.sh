#!/bin/bash
set -euo pipefail

# Bootstrap dotfiles from a bare Git repository
# WARNING: This will checkout dotfiles into $HOME. Conflicting files will be backed up.

readonly GIT_CMD="/usr/bin/git"
readonly DOTFILES_REPO="https://github.com/jugheadny/dotfiles.git"
readonly CONFIG_DIR="${HOME}/.cfg"
readonly BACKUP_DIR="${HOME}/.config-backup"

# Wrapper function for git operations on the dotfiles repo
config() {
  "${GIT_CMD}" --git-dir="${CONFIG_DIR}/" --work-tree="${HOME}" "$@"
}

# Error handling
trap 'echo "Error: Bootstrap failed at line $LINENO" >&2; exit 1' ERR

# Clone the bare repository
clone_dotfiles_repo() {
  echo "Cloning dotfiles repository..."
  git clone --bare "${DOTFILES_REPO}" "${CONFIG_DIR}"
}

# Create backup directory
setup_backup_dir() {
  echo "Setting up backup directory..."
  mkdir -p "${BACKUP_DIR}"
}

# Checkout dotfiles, backing up conflicts
checkout_dotfiles() {
  echo "Checking out dotfiles..."
  if ! config checkout 2>/dev/null; then
    echo "Backing up pre-existing dotfiles to ${BACKUP_DIR}"
    config checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | \
      while read -r file; do
        mv "${file}" "${BACKUP_DIR}/" 2>/dev/null || true
      done
    config checkout
  fi
}

# Configure git to hide untracked files
configure_git() {
  echo "Configuring git..."
  config config --local status.showUntrackedFiles no
  config config --local user.name "Robert K. Carroll"
  config config --local user.email "rcarroll@cubicle13.com"
}

# Main execution
main() {
  echo "Starting dotfiles bootstrap..."
  clone_dotfiles_repo
  setup_backup_dir
  checkout_dotfiles
  configure_git
  echo "Bootstrap complete!"
  echo "Tip: Add this alias to your shell config:"
  echo "  alias config='${GIT_CMD} --git-dir=${CONFIG_DIR}/ --work-tree=${HOME}'"
}

main "$@"