#! /bin/bash

# for linuxbrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

# for fonts
cp -r .fonts ${HOME}/
fc-cache -vf

# for vim
cp -r .vimrc  ${HOME}/
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir -p ${HOME}/.vim/colors
cd ${HOME}/.vim/colors
wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim 
vim +PluginInstall +qall

# Compile and install YouCompleteMe
cd ${HOME}/.vim/bundle/YouCompleteMe
python3 install.py --clang-completer
# compileing YouCompleteMe for VIM
# cd /tmp
# wget http://releases.llvm.org/6.0.0/clang+llvm-6.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz
# mv clang+llvm* clang.tar.xz; tar xJf clang.tar.xz;
# rm clang.tar.xz; mv clang+llvm* ${HOME}/llvm_root
# mkdir -p ${HOME}/.vim/bundle/YouCompleteMe/ycm_build
# cd ${HOME}/.vim/bundle/YouCompleteMe/ycm_build
# cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=${HOME}/llvm_root \
#     . ${HOME}/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
# cmake --build . --target ycm_core


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

