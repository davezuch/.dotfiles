#! /usr/bin/zsh

# install zsh and prezto configs
rm -f ~/.zshrc
setopt EXTENDED_GLOB
for rcfile in ~/.dotfiles/prezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" ~/.${rcfile:t}
done
cd -

#
