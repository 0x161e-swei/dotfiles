#! /bin/bash

# for linuxbrew
if [ ! -d "${HOME}/.linuxbrew" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
fi

export PATH="${PATH}:${HOME}/.linuxbrew/bin"

# tmux
cp tmux.conf ${HOME}/.tmux.conf

# for fonts
cp -r fonts ${HOME}/.fonts
fc-cache -vf

# brew fzf and install into vim
brew install fzf

# for vim
cp vimrc  ${HOME}/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Manually install the newest version of taglist
cd ${HOME}/.vim
wget https://cfhcable.dl.sourceforge.net/project/vim-taglist/vim-taglist/4.6/taglist_46.zip
unzip taglist_46.zip; rm taglist_46.zip


mkdir -p ${HOME}/.vim/colors
cd ${HOME}/.vim/colors
wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim 
vim +PluginInstall +qall

# Compile and install YouCompleteMe
cd ${HOME}/.vim/bundle/YouCompleteMe
python3 install.py --clang-completer

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
