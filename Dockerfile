FROM archlinux/base

RUN yes "" | pacman -Syy wget neovim base-devel git tmux 
RUN useradd -m -s /bin/bash gly
RUN echo 'Defaults visiblepw'             >> /etc/sudoers
RUN echo 'gly ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER gly
WORKDIR /home/gly
RUN git clone https://aur.archlinux.org/c9.core.git
RUN cd c9.core \
&& echo "  git reset HEAD --hard" | sed 's:  git reset HEAD --hard bash:git checkout HEAD -- node_modules:g' \
&& yes "" | makepkg -si
RUN rm -r ~/c9.core

ENTRYPOINT ["sh", "-c", "/usr/bin/node /opt/cloud9/server.js -l 0.0.0.0 -p 8080 -w /home/gly -a : "]
