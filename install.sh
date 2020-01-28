#!/bin/bash

# Install Terminal

install_inital_tools() {
    echo "Installing tools necessary..."
    printf "Installing curl: "
    if [ -f  /usr/bin/curl ]; then
        echo "ok"
    else
        apt install curl -y
    fi

    printf "Installing git: "

    if [ -f  /usr/bin/git ]; then
        echo "ok"
    else
        apt install git -y
    fi

    printf "Tools necessary installed\n\n"
}

install_zsh() {
    read -p "Install zsh? [s/n]: " zsh

    if [ "$zsh" = "s" ]; then
        if [ -f /usr/bin/zsh ]; then
            echo "Zsh already installed"
        else
            apt install zsh -y
        fi
        echo "Skipping zsh"
    fi
}

set_zsh_how_default() {
    read -p "Set zsh how default? [s/n]: " zsh_default

    if [ "$zsh_default" = "s" ]; then
        chsh -s $(which zsh)
    fi
}

install_oh_my_zsh() {
    read -p "Install Oh My Zsh? [s/n]: " omz
    if [ "$omz" = "s" ]; then
        if [ -f $HOME/.oh-my-zsh/oh-my-zsh.sh ]; then
            echo "Oh My Zsh already installed"
        else
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        fi
    fi
}

install_spaceship() {
    read -p "Install spaceship? [s/n]: " spaceship
    if [ "$spaceship" = "s" ]; then
        if [ -f $HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme ]; then
            echo "Spaceship already installed"
        else
            git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" && ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
        fi
    fi
}

install_gnome_dracula_theme() {
    read -p "Install gnome dracula theme? [s/n]: " gnome_dracula
    if [ "$gnome_dracula" = "s" ]; then
        git clone https://github.com/dracula/gnome-terminal && cd gnome-terminal && chmod +x ./install.sh && ./install.sh
    fi
}

install_plugins() {
    read -p "Install plugins? [s/n]: " plugins
    if [ "$plugins" = "s" ]; then
        if [ -f $HOME/.zplugin/bin/zplugin.zsh ]; then
            echo "Zplugin already installed"
        else
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
        fi

    fi
}

config_terminal() {

    read -p "Config terminal? [s/n]: " terminal

    if [ "$terminal" = "s" ]; then
        install_zsh
        install_oh_my_zsh
        install_spaceship
        install_plugins
        install_gnome_dracula_theme
        set_zsh_how_default
        source ~/.zshrc

        printf "Terminal settings finished!\n\n"

    fi


}

# Install Enviroment

install_nvm() {
    read -p "Install nvm? [s/n]: " nvm
    if [ "$nvm" = "s" ]; then
        if [ -f $HOME/.nvm/nvm.sh ]; then
            echo "Nvm already installed"
        else
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

            echo "Please finish the setup, read the AFTERSCRIPT.md"
        fi
    fi
}

install_yarn() {
    read -p "Install yarn? [s/n]: " yarn
    if [ "$yarn" = "s" ]; then
        if [ -f /usr/bin/yarn ]; then
            echo "Yarn already installed"
        else
            curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt install --no-install-recommends yarn -y

            echo "Please finish the setup, read the AFTERSCRIPT.md"
        fi
    fi
}

install_docker() {
    read -p "Install docker? [s/n]: " docker
    if [ "$docker" = "s" ]; then
        if [ -f /usr/bin/docker ]; then
            echo "Docker already installed"
        else
            echo "Uninstall old versions"
            apt-get remove docker docker-engine docker.io  containerd runc -y

            printf "What your distro? \n[1] Ubuntu (default)\n[2] Debian\nSelect: "
            read distro_opt
            [[ "$distro_opt" = "2" ]] && distro="debian" || distro="ubuntu"

            apt update && apt install apt-transport-https ca-certificates gnupg2 software-properties-common -y && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$distro $(lsb_release -cs) stable" && apt update && apt install docker-ce docker-ce-cli containerd.io -y

            read -p "Set docker setup without sudo? [s/n]: " global_docker
            if [ "$global_docker" = "s" ]; then
                groupadd docker && usermod -aG docker $USER && newgrp docker
            fi

            read -p "Enable Docker to start on boot? [s/n]: " boot_docker
            if [ "$boot_docker" = "s" ]; then
                systemctl enable docker
            fi
        fi
    fi
}

# Install tools

install_insomnia() {
    read -p "Install Insomnia? [s/n]: " insomnia
    if [ "$insomnia" = "s" ]; then
        if [ -f /usr/bin/insomnia ]; then
            echo "Insomnia already installed"
        else
            echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" |  tee -a /etc/apt/sources.list.d/insomnia.list && wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | apt-key add - && apt update && apt install insomnia -y
        fi
    fi
}

install_vscode() {

    read -p "Install VsCode? [s/n]: " vscode
    if [ "$vscode" = "s" ]; then
        if [ -f /usr/bin/code ]; then
            echo "VsCode already installed"
        else
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ && sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && apt install apt-transport-https -y && apt update && apt install code -y

        fi
    fi

}

# Check if we're root and re-execute if we're not.

rootcheck () {
    if [ $(id -u) != "0" ]
    then
        sudo "$0" "$@"  # Modified as suggested below.
        exit $?
    fi
}

#Main

main() {
    rootcheck
    echo "deb [arch=amd64] https://download.docker.com/linux/$distro $(lsb_release -cs) stable"
    # echo "Author: Ellyo Freitas"
    # printf "Starting script...\n\n"
    # install_inital_tools

    # config_terminal

    # install_nvm
    # install_yarn
    # install_docker

    # install_vscode
    # install_insomnia

    # printf "\nScript finish.\n"
    # echo "Thanks for using!"
    # printf "If you liked it, leave a star on github: https://github.com/ellyofreitas/default-dev-environment-js\n"
}


main
