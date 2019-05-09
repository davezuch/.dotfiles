#! /bin/bash

echo "Setting up dotfiles"
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# install python3, pip, ag, neovim
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y python-pip python3 python3-pip silversearcher-ag neovim

# install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install --no-install-recommends yarn

# install purs
yarn global add request purescript pulp

# install nvm and node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install node

# upgrade neovim
sudo pip install --upgrade neovim
sudo pip3 install --upgrade neovim

# install jedi completion engine
sudo pip install jedi
sudo pip3 install jedi

# setup neovim config
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install youcompleteme
sudo apt install -y build-essential cmake python3-dev
( cd ~/.config/nvim
  nvim +PlugUpdate +qa
  cd ~/.local/share/nvim/plugged/YouCompleteMe
  python3 install.py
)
helpztags ~/.local/share/nvim/plugged/psc-ide-vim/doc

# setup prezto configs
sudo apt install zsh
chsh -s $(which zsh)
git pull
( cd ~/.dotfiles/prezto
  git submodule update --init --recursive
)
sudo zsh ~/.dotfiles/setup_prezto.zsh

# install nix
sh <(curl https://nixos.org/nix/install) --no-daemon
sudo chown $USER /nix

# iterm integration
bash <(curl https://iterm2.com/misc/install_shell_integration.sh)
