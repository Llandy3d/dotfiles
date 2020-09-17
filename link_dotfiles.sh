mkdir -p $HOME/.vim && ln -s $(pwd)/coc-settings.json $HOME/.vim/
mkdir -p $HOME/.config/sway && ln -s $(pwd)/.config/sway/config $HOME/.config/sway/
mkdir -p $HOME/.config/alacritty && ln -s $(pwd)/.config/alacritty/alacritty.yml $HOME/.config/alacritty/
ln -s $(pwd)/.vimrc $HOME/
ln -s $(pwd)/after $HOME/.vim/
ln -s $(pwd)/.inputrc $HOME/
ln -s $(pwd)/.pythonrc.py $HOME/
ln -s $(pwd)/flake8 $HOME/.config/
ln -s $(pwd)/.gitconfig $HOME/
rm $HOME/.bashrc && ln -s $(pwd)/.bashrc $HOME/

for file in $(pwd)/bin/* ; do ln -s $file $HOME/.local/bin/ ; done

