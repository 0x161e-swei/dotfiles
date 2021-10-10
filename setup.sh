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

# TODO: add checks for these tools
# brew fzf and install into vim
brew install fzf
brew install vim
brew install cmake
brew uninstall ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags


# install fish
brew install fish
if [ ! -d "${HOME}/.local" ]; then
    mkdir ${HOME}/.local
fi
git clone https://github.com/oh-my-fish/oh-my-fish  ${HOME}/.local/oh-my-fish
fish ${HOME}/.local/oh-my-fish/bin/install --offline  \
    --path=${HOME}/.local/share/omf --config=${HOME}/.config/omf
fish -c 'omf install bobthefish'
fish -c "curl -sL https://git.io/fisher | source && \
    fisher install jorgebucaran/fisher && \
    fisher install acomagu/fish-async-prompt"

mkdir -p $HOME/.config/fish
cp fish.config $HOME/.config/fish/
cp -r dir_colors $HOME/.custom_dir_colors

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

# auto install cargo without configs
curl https://sh.rustup.rs -sSf | sh -s -- -y
$HOME/.cargo/bin/cargo install git-delta
cp gitconfig $HOME/.gitconfig

