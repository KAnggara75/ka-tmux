#! /bin/zsh

CONFIG=~/.tmux.conf
CONFIG_LOCAL=~/.tmux.conf.local
KA_DIR=~/.tmux/themes/ka-tmux
rm -rf $KA_DIR
if (git --version) | sort -Vk3 | tail -1 | grep -q git
then
  echo "Check Config Files"
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
  # echo -e "Installing Powerline Fonts"
  # git clone https://github.com/powerline/fonts.git --depth=1
  # cd fonts && ./install.sh && cd .. && rm -rf fonts
  # echo "Cloning Repo."
  git clone https://github.com/kanggara75/ka-tmux.git --depth=1 $KA_DIR
  cd $KA_DIR
  rm -rf docs && rm -rf .git
  rm .editorconfig && rm CHANGELOG.md && rm LICENSE && rm README.md && rm install.sh
  mv ~/.tmux/themes/ka-tmux/tmux.conf ~/.tmux.conf
  if (cat ~/.zshrc | grep -q "tmux attach;")
  then
    echo ""
  else
    echo 'if [ "$TMUX" = "" ]; then exec tmux attach; fi' | cat - ~/.zshrc > temp && mv temp ~/.zshrc
  fi
  # source ~/.zshrc
else
  echo "Git is not installed."
  echo "Installing git using Homebrew."
  if (brew -v) | sort -Vk3 | tail -1 | grep -q brew
  then
    brew install git
  else
    echo "Homebrew is not installed."
    echo "Installing Homebrew then git."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install git
  fi
  ./install.sh
fi

clear