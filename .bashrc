source /usr/local/etc/bash_completion.d/git-completion.bash
export CLICOLOR=1  # same as 'alias ls=ls -G' which I also have set

export LSCOLORS=gxfxcxdxbxegedabagacad

# Need to do this so you use backspace in screen apparently
# alias screen='TERM=screen screen'

# display battery info on your Mac
# see http://blog.justingreer.com/post/45839440/a-tale-of-two-batteries
alias battery='ioreg -w0 -l | grep Capacity | cut -d " " -f 17-50'

# Enable color in grep
# export GREP_OPTIONS='--color=auto'
# export GREP_COLOR='3;33'
 
# Enable italics
export TERM=xterm-256color-italic

# general shortcuts
alias mv='mv -i'
alias rm='rm -i'

# listing files
alias l='ls -al'
alias la='ls -a'

# editing shortcuts
alias m='mate'
alias v='vi'
alias vim='vi'
alias n='nvim'
alias sublime='open -a "/Applications/Sublime Text.app"'

alias g='git '
alias gs='git status'
alias gp='git pull'
alias gd='git diff'
alias gc='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gcm='git checkout master'
alias gcd='git checkout development'

# COLOR STRINGS
        RED="\[\033[0;31m\]"
     ORANGE="\[\033[0;33m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

# only using interactive shell for aws cli right now, so prefix it with aws
function gitprompt () {
	local gitbranch=$(git branch 2>&1 | grep '\*' | sed -e 's/\* //g')
	if [[ "$gitbranch" != "" ]]; then
      PS1="\n${RED}« aws » ${GREEN}\w -${BLUE} ${gitbranch} ${GREEN}\n➔ ${LIGHT_GRAY}"
    else
      PS1="\n${RED}« aws » ${GREEN}\w${BLUE} ${GREEN}\n➔ ${LIGHT_GRAY}"
    fi
}
PROMPT_COMMAND=gitprompt

SSH_KNOWN_HOSTS=( $(cat ~/.ssh/known_hosts | \
  cut -f 1 -d ' ' | \
  sed -e s/,.*//g | \
  uniq | \
  egrep -v [0123456789]) )
SSH_CONFIG_HOSTS=( $(cat ~/.ssh/config | grep "Host " | grep -v "*" | cut -f 2 -d ' ') )

complete -o default -W "${SSH_KNOWN_HOSTS[*]} ${SSH_CONFIG_HOSTS[*]}" ssh

WHOAMI=$(whoami)
export NODE_PATH="/usr/local/bin/node:/usr/local/lib/node_modules:{$WHOAMI}/lib/node_modules"
export NODE_ENV=development
export NVIMPATH="~/.config/nvim"

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

alias gorv='cd /Users/zjohnson/gocode/src/github.com/RedVentures'
alias gostash='cd /Users/zjohnson/gocode/src/stash.redventures.net'
alias gogit='cd /Users/zjohnson/gocode/src/github.com'
alias gop='cd $GOPATH/src'
alias goir='cd $GOPATH/src/stash.redventures.net/irw/ir-apex'
alias goplay='cd $GOPATH/src/scratch; n main.go'

export GOPATH=$HOME/gocode
export GOROOT=/usr/local/go

export NVIMPATH=~/.config/nvim
alias c='clear'
alias h='cd ~'
alias cd1='cd ..'
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../../..'
alias cd5='cd ../../../../../..'
alias onvim='nvim ~/.config/nvim/init.vim'
alias otmux='nvim ~/.tmux.conf'
alias nn='cd ~/.config/nvim'
alias ns='n -S Session.vim'
alias ndot='cd ~/dotfiles && n -S Session.vim'

alias tf='terraform'

# docker
alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'
eval $(dm env)
# remove untagged images
alias dremove='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'

# Export a .env file
alias expenv='export `cat .env | xargs`'

export NVM_DIR="/Users/zjohnson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export GIT_EDITOR=nvim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# make fzf use ag
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS=''

# History: don't store duplicates
export HISTCONTROL=ignoreboth:erasedups
# History: 10,000 entries
export HISTSIZE=10000

# apex autocomplete
_apex()  {
  COMPREPLY=()
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local opts="$(apex autocomplete -- ${COMP_WORDS[@]:1})"
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

function title {
    echo -ne "\033]0;"$*"\007"
}

function wdt {
    echo -ne "\033]0;"${PWD##*/}"\007"
}

complete -F _apex apex

export PATH='/Users/zjohnson/.nvm/versions/node/v8.11.3/bin:/Users/zjohnson/gocode/bin:/usr/local/go/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/opt/fzf/bin:/Users/zjohnson/.cargo/bin:/Library/Frameworks/Python.framework/Versions/3.6/bin'
