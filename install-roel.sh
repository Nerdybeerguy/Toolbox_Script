#!/bin/zsh

set -eu -o pipefail

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo repistory update
sudo pacman -Syu
sudo pacman -Syyu

echo installing the must-have pre-requisites
while read -r p ; do sudo pacman -Sy --noconfirm $p ; done < <(cat << "EOF"
	flameshot
	ripgrep
	bat
	lsd
	tmux
	pacseek
	fd
EOF
)

echo oh-my-zsh installeren
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sleep 5
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting/
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

echo variable aanpassen
echo -e "\n"
sleep 1
export PATH=$PATH:/home/kali/.local/bin

echo "Setting up the terminal how you like it"
echo -e "\n"
sleep 2
echo export PATH=$PATH:~/.local/bin >> ~/.zshrc

echo "alias grep='rg'" >> ~/.zshrc
echo "alias ls='lsd -al --group-directories-first'" >> ~/.zshrc
echo "alias cat='bat'" >> ~/.zshrc
echo "alias find='fd'" >> ~/.zshrc
echo "alias yay='pacseek" >> ~/.zshrc'

source ~/.zshrc

echo "Setting up your special tmux hacking  setting"
sleep 1
cd
git clone https://github.com/Nerdybeerguy/.tmux.git
sleep 1
ln -s -f .tmux/.tmux.conf
sleep 1
cp .tmux/.tmux.conf.local .

echo "Installation complete, happy Linuxing!"
