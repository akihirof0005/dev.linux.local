#!/bin/bash
git clone https://aur.archlinux.org/yay.git ~/yay
cd ~/yay
yes "" | makepkg -si
### edit below command ...
#yay -S rbenv etc...
rm ~/yay
