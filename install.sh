# Install spaceship prompt
git clone https://github.com/spaceship-prompt/spaceship-prompt.git $HOME/.oh-my-zsh/custom/themes/spaceship-prompt --depth=1

# Install ZSH syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Update debian dependancies
if command -v apt-get &> /dev/null; then
  sudo apt-get update
  sudo apt-get install -y bat
fi

# Create symlinks
ln -nfs $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -nfs $HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme $HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme