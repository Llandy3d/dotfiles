mkdir -p $HOME/.vim && ln -s $(pwd)/coc-settings.json $HOME/.vim/
ln -s $(pwd)/.vimrc $HOME/
ln -s $(pwd)/.inputrc $HOME/
ln -s $(pwd)/.pythonrc.py $HOME/
ln -s $(pwd)/flake8 $HOME/.config/
ln -s $(pwd)/.gitconfig $HOME/
rm $HOME/.bashrc && ln -s $(pwd)/.bashrc $HOME/
