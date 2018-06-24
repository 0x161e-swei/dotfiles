#! /bin/bash

# for linuxbrew
if [ ! -d "${HOME}/.linuxbrew" ]; then
    echo "Setting up linux brew, Ctrl-D to install locally"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
fi

export PATH="${HOME}/.linuxbrew/bin:${PATH}"

# tmux
# cp tmux.conf ${HOME}/.tmux.conf

# for fonts
cp -r fonts ${HOME}/.fonts
fc-cache -vf

# brew fzf and install into vim
# TODO: add checks for these tools
brew install fzf
brew install vim
brew install cmake
brew uninstall ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# for vim
cp vimrc  ${HOME}/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Manually install the newest version of taglist


mkdir -p ${HOME}/.vim/colors
cd ${HOME}/.vim/colors
wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim 
vim +PlugInstall +qall

# Making sure flygrep opens on split
sed -i "s/exe 'e '/exe 'vsp '/" \
        ${HOME}/.vim/plugged/FlyGrep.vim/autoload/SpaceVim/plugins/flygrep.vim

# Compile and install YouCompleteMe
# cd ${HOME}/.vim/plugged/YouCompleteMe
# python3 install.py --clang-completer

# git diff
brew install diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

git config --global color.ui true

git config --global color.diff-highlight.oldNormal      "red bold"
git config --global color.diff-highlight.oldHighlight   "red bold 52"
git config --global color.diff-highlight.newNormal      "green bold"
git config --global color.diff-highlight.newHighlight   "green bold 22"

git config --global color.diff.meta                     "yellow"
git config --global color.diff.frag                     "magenta bold"
git config --global color.diff.commit                   "yellow bold"
git config --global color.diff.old                      "red bold"
git config --global color.diff.new                      "green bold"
git config --global color.diff.whitespace               "red reverse"

# git name
git config --global user.name                           "Shijia Wei"
git config --global user.email                          "swei@`uname -n`"

# git editor
git config --global core.editor                         "vim"
