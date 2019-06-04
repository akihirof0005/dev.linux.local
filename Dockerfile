FROM archlinux/base

RUN yes "" | pacman -Syy base-devel 
RUN yes "" | pacman -Syy wget neovim git tmux 

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

ENTRYPOINT ["sh", "-c", "/usr/bin/node /opt/cloud9/server.js -l 0.0.0.0 -p 8080 -w /home/docker -a : "]
