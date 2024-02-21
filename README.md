# Instalação do Gentoo de forma automatizada!

# Como que faz?
### Antes de começar atualize seu repositório.
emerge --sync && emerge-webrsync && emerge --update --deep --with-bdeps=y --newuse @world
### E execute os comandos abaixo, mas com cuidado!

emerge --ask app-shells/bash-completion

emerge --ask dev-vcs/git

git clone https://github.com/CartySlackware/ScriptGentooLifeInstall.git
# Instalação Final do Script
### Execute os comandos abaixo, mas com cuidado!
cd /home/$HOME=*/ScriptGentooLifeInstall

chmod 777 ScriptGentooLifeInstall.sh

bash ScriptGentooLifeInstall.sh
# Pronto!!!
### Aguarde a instalação.
