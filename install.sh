#!/bin/bash
# KAnggara Terminal Automatic Installer
# url: https://github.com/kanggara75/ka-tmux

# Global Variable
HOST=google.com
CONFIG=~/.tmux.conf
KA_DIR=~/.tmux/themes/ka-tmux
CONFIG_LOCAL=~/.tmux.conf.local
OH_ZSH_DIR=~/.oh-my-zsh/oh-my-zsh.sh
PL_REPO=https://github.com/powerline/fonts.git
KA_REPO=https://github.com/kanggara75/ka-tmux.git

main()
{
  if ping -q -c 1 -W 1 $HOST > /dev/null;  then
    cos
  else
    echo "You are not connected to the internet"
    exit 0
  fi
  clear
  zsh
}

cos()
{
  if (uname -a) | grep -q Darwin
  then
    echo "Mac OS X"
    cbrew
  elif (uname -a) | grep -q Linux
  then
    echo "Not support Linux yet"
  else
    echo "Unknown OS"
  fi 
  cgit
}

cbrew()
{
  if (brew -v) | sort -Vk3 | tail -1 | grep -q brew
  then
    echo -n "Homebrew is already installed => "
    brew -v
  else
    echo "Homebrew is not installed."
    echo "Installing Homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  citerm
}

citerm()
{
  if (  mdfind "kMDItemCFBundleIdentifier == com.googlecode.iterm2" ) | grep -q app
  then
    echo "iTerm2 is already installed"
  else
    echo "iTerm2 is not installed"
    echo "Installing iTerm2"
    brew install --cask iterm2
  fi
}

cgit()
{
  if (git --version) | sort -Vk3 | tail -1 | grep -q git
  then
    echo -n "Git is already installed. => "
    git --version
  else
    echo "Git is not installed."
    echo "Installing Git."
    brew install git
  fi
  cexa
}

cexa()
{
  if (exa -v) | sort -Vk3 | tail -1 | grep -q zsh
  then
    echo -n "Exa is already installed. => "
    exa -v
  else
    echo "Exa is not installed."
    echo "Installing Exa."
    brew install exa
  fi
  czsh
}

czsh()
{
  if (zsh --version) | sort -Vk3 | tail -1 | grep -q zsh
  then
    echo -n "Zsh is already installed. => "
    zsh --version
  else
    echo "Zsh is not installed."
    echo "Installing Zsh."
    brew install zsh
  fi
  ctmux
}

ctmux()
{
  if (tmux -V) | sort -Vk3 | tail -1 | grep -q tmux
  then
  echo -n "Tmux is already installed. => "
  tmux -V
  else 
  echo "Tmux is not installed."
  echo "Installing Tmux."
  brew install tmux
  fi
  cfont 
} 

cfont()
{
  if (fc-list) | grep -q powerline
  then
    echo "Powerline Fonts is already installed."
  else
    echo "Installing Powerline Fonts"
    git clone $PL_REPO --depth=1
    cd fonts && ./install.sh && cd .. && rm -rf fonts
  fi
  ohzsh
}

ohzsh()
{
  if [ -f $OH_ZSH_DIR ]
  then
    echo "Oh-my-zsh is already installed."
  else
    echo "Installing Oh-my-zsh"
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  fi
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  ckadir
}

ckadir()
{
  if [ -f ${KA_DIR}/kanggara.tmux ] 
  then
    rm -rf $KA_DIR
  fi
  ccfg
}

ccfg()
{
  if [ -f $CONFIG ]
  then
    echo "Configuration file found"
    echo "Backup your existing configuration"
    mv $CONFIG ~/.tmux.conf.bak
    if [ -f $CONFIG_LOCAL ]
    then
      echo "Configuration local file found"
      echo "Backup your existing configuration"
      mv  $CONFIG_LOCAL ~/.tmux.conf.local.bak
    fi
  fi
  rclone
}

rclone()
{
  echo "Cloning Repo."
  git clone $KA_REPO --depth=1 $KA_DIR
  rm -rf ${KA_DIR}/docs && rm -rf ${KA_DIR}/.git
  rm ${KA_DIR}/.editorconfig && rm ${KA_DIR}/CHANGELOG.md
  rm ${KA_DIR}/LICENSE && rm ${KA_DIR}/README.md && rm ${KA_DIR}/install.sh
  mv ${KA_DIR}/tmux.conf ~/.tmux.conf
  runconfig
}

runconfig()
{
  clear
  echo "Use your zsh config?"
  echo "y = Yes"
  echo "n = No"
  echo "q = Quit"
  read -p "Enter your choice: " choice
  if [ $choice = "y" ]
  then
    czshconfig
  elif [ $choice = "n" ]
  then
    rm ${KA_DIR}/zshrc
    ctmuxa
  elif [ $choice = "q" ]
  then
    clear
    echo "Quit, bye"
    exit 0
  else
    echo "Please enter y or n"
    runconfig
  fi
}

czshconfig()
{
  if [ -f ~/.zshrc ]
  then
    echo "Backup your existing zshrc"
    cp ~/.zshrc ~/.zshrc.bak
  else
    echo "No zshrc found"
  fi
  mv ~/.tmux/themes/ka-tmux/zshrc ~/.zshrc
}

ctmuxa()
{
  if [ -f ~/.zshrc ]
  then
    if ( cat ~/.zshrc  | grep -q "exec tmux" )
    then
      echo "exec tmux already added to zshrc"
      echo "Enable it if disabled"
    else
      echo 'if [ "$TMUX" = "" ]; then exec tmux attach; fi' | cat - ~/.zshrc > temp && mv temp ~/.zshrc
    fi
  else
    echo "No zshrc found"
    echo "write my own zshrc"
    czshconfig
  fi
}

main
