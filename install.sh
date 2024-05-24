# Install spaceship prompt
git clone https://github.com/spaceship-prompt/spaceship-prompt.git $HOME/.oh-my-zsh/custom/themes/spaceship-prompt --depth=1

# Install ZSH syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Update debian dependancies
if command -v apt-get &> /dev/null; then
  sudo apt-get update
  sudo apt-get install -y bat
fi

# Install starship prompt
curl -sS https://starship.rs/install.sh >> install_starship.sh
sh install_starship.sh --yes

# Create symlinks
./createSymLinks.sh
