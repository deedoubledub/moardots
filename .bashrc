#- - - - - - - - - - - - - - - - - - -#
#               environment variables #
#- - - - - - - - - - - - - - - - - - -#

export EDITOR=nvim
export TERMINAL=alacritty
export PATH=$PATH:~/.local/bin:~/go/bin
export PASSWORD_STORE_DIR=~/git/homelab/secrets

#- - - - - - - - - - - - - - - - - - -#
#                             general #
#- - - - - - - - - - - - - - - - - - -#

# if not interactive, don't do anything
[[ $- != *i* ]] && return

# directory colors
[[ -f ~/.config/dircolors ]] && eval $(dircolors ~/.config/dircolors)

# aliases
[[ -f ~/.config/alias ]] && . ~/.config/alias

# completion
[[ -f /etc/profile.d/bash_completion.sh ]] && . /etc/profile.d/bash_completion.sh
[[ -f ~/.talos/completion.bash ]] && . ~/.talos/completion.bash

# set caps-lock as another ctrl
setxkbmap -option ctrl:nocaps

# enables autocd, interpret dir_name as cd dir_name
shopt -s autocd

# gam setup
gam() { "$HOME/.local/bin/gam/gam" "$@" ; }

#- - - - - - - - - - - - - - - - - - -#
#                            ssh keys #
#- - - - - - - - - - - - - - - - - - -#

# ssh-agent setup
if [ -f ~/.ssh/agent.env ] ; then
  . ~/.ssh/agent.env > /dev/null
  if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
    # stale agent, start a new one
    eval `ssh-agent | tee ~/.ssh/agent.env` > /dev/null 2>&1
  fi
else
  # start an agent
  eval `ssh-agent | tee ~/.ssh/agent.env` > /dev/null 2>&1
fi

# add all private keys found in ~/.ssh
for filename in ~/.ssh/*; do
  type=`file "$filename" | awk -F ": " '{print $2}'`
  if [[ $type == "PEM RSA private key" ]]; then
    ssh-add $filename >/dev/null 2>&1
  fi
done

#- - - - - - - - - - - - - - - - - - -#
#                              prompt #
#- - - - - - - - - - - - - - - - - - -#

# git prompt
source ~/.local/bin/bash-git-prompt.sh

PROMPT_COMMAND=prompt

# build prompt
prompt() {
  # left prompt
  PS1="\[\e[32m\]\u\[\e[m\]\[\e[31m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[33m\]\`parse_git_branch\`\[\e[m\] \[\e[34m\]"$'\u2771 \[\e[m\]'

  # right prompt
  width=$(expr `tput cols` - 1)
  printf "\033[1;34m%${width}s`tput cr`" $(pwd | sed "s:^$HOME:~:")
}
