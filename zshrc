if [ "$TMUX" = "" ]; then exec tmux attach; fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/k/.oh-my-zsh"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ZSH_THEME="agnoster"
DISABLE_UPDATE_PROMPT="true"

plugins=(git zsh-autosuggestions)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'

source $ZSH/oh-my-zsh.sh

# export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_212.jdk/Contents/Home

# Adb and android tools
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH=/Users/k/bin:$PATH
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/Users/k/.composer/vendor/bin:$PATH
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH="/usr/local/opt/php@8.0/bin:$PATH"
export PATH="/usr/local/opt/php@8.0/sbin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH:/Users/k/dev/flutter/bin"
export PATH="/usr/local/opt/node@16/bin:$PATH"

# Git Custom alisa
alias ghpage="git add . && git status && git commit -m 'Some descriptive commit message' && git push origin master && git checkout gh-pages && git rebase master && git push origin gh-pages && git checkout master"
alias gcr="git checkout release"
alias ghcreate="gh repo create $1 --public"

# Flutter alias
alias fpg="flutter pub get"
alias frn="flutter run"
alias fcl="flutter clean"
alias fcrun="fcl && fpg && frn"
alias fcr="flutter create $1"

#mySQL Alias
alias startsql="brew services start mysql"
alias stopsql="brew services stop mysql"

# Python Virtual Env
alias venv="python -m venv env && source env/bin/activate"
alias act="source env/bin/activate"

# ZSH Alias
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias reload="source ~/.zshrc"

# Cusom Alias
alias q="exit"
alias mku="cd /Users/k/Work/kuroject_mac"
alias kuroject="cd /Volumes/DATA/kuroject"
alias 2022="cd /Volumes/DATA/Downloads/2022"
alias kan="cd /Volumes/DATA/kuroject/KAnggara"
alias ka75="cd /Volumes/DATA/kuroject/KAnggara75"
alias gotmp-web="/Users/k/Work/kuroject_mac/KAnggara/gotmp/web"
alias gotmp-app="/Users/k/Work/kuroject_mac/KAnggara/gotmp/app"

# Thesis Project alias
alias thesis-web="cd /Users/k/Work/kuroject_mac/KAnggara75/TheSiS/web"
alias thesis-app="cd /Users/k/Work/kuroject_mac/KAnggara75/TheSiS/app"

# my Project Folder
alias sil="cd /Volumes/DATA/kuroject/KAnggara75/SiListrik/docs"
alias siapi="cd /Volumes/DATA/kuroject/KAnggara75/SiListrik/api"
alias siapp="cd /Volumes/DATA/kuroject/KAnggara75/SiListrik/app"
alias siuno="cd /Volumes/DATA/kuroject/KAnggara75/SiListrik/uno"

# Web Framework alias
alias ci4="composer create-project codeigniter4/appstarter --no-dev $1"

# DNS cache Clear
alias dnsclear="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# PHP Change version
alias sp80="brew unlink php && brew link --overwrite --force php@8.0"
alias sp81="brew unlink php && brew link --overwrite --force php@8.1"

# eval "$(pyenv init -)"
prompt_context () {}
