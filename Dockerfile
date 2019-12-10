FROM archlinux/base
RUN wget https://www.archlinux.org/mirrorlist/\?country\=JP\&protocol\=https\&ip_version\=4\&ip_version\=6 -O /etc/pacman.d/mirrorlist && sed -e "s/^#//g" /etc/pacman.d/mirrorlist
RUN yes "" | pacman -Syy base-devel 
RUN yes "" | pacman -Syy curl neovim git tmux 

RUN useradd -m -s /bin/bash docker
RUN echo 'Defaults visiblepw'            >> /etc/sudoers
RUN echo 'docker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker 
WORKDIR /home/docker

RUN git clone https://aur.archlinux.org/c9.core.git
RUN cd c9.core \
&& echo "  git reset HEAD --hard" | sed 's:  git reset HEAD --hard bash:git checkout HEAD -- node_modules:g' \
&& yes "" | makepkg -si
RUN rm -r ~/c9.core

## please exchange URL(ex, your gist),to costomize your docker image.
RUN curl -s https://raw.githubusercontent.com/akihirof0005/dev.linux.local/master/aurPackageInstall.sh | bash

ENTRYPOINT ["sh", "-c", "/usr/bin/node /opt/cloud9/server.js -l 0.0.0.0 -p 8080 -w /home/docker -a : "]
