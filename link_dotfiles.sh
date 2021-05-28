mkdir -p $HOME/.vim && ln -s $(pwd)/coc-settings.json $HOME/.vim/
mkdir -p $HOME/.vim/swp
mkdir -p $HOME/.config/alacritty && ln -s $(pwd)/.config/alacritty/alacritty.yml $HOME/.config/alacritty/
ln -s $(pwd)/.vimrc $HOME/
ln -s $(pwd)/after $HOME/.vim/
ln -s $(pwd)/.inputrc $HOME/
ln -s $(pwd)/.pythonrc.py $HOME/
ln -s $(pwd)/flake8 $HOME/.config/
ln -s $(pwd)/.gitconfig $HOME/
ln -s $(pwd)/.pam_environment $HOME/
ln -s $(pwd)/.config/sway $HOME/.config
ln -s $(pwd)/.config/waybar $HOME/.config/
ln -s $(pwd)/.config/mako $HOME/.config/
rm $HOME/.bashrc && ln -s $(pwd)/.bashrc $HOME/

for file in $(pwd)/bin/* ; do ln -s $file $HOME/.local/bin/ ; done
mkdir -p $HOME/.fonts && for file in $(pwd)/.fonts/* ; do ln -s "$file" $HOME/.fonts/ ; done

ln -s $(pwd)/background/icy-scenery.jpg $HOME/.config/sway/background
