#- - - - - - - - - - - - - - - - - - -#
#                           variables #
#- - - - - - - - - - - - - - - - - - -#

export TERM=rxvt-256color
export EDITOR=vim
export TERMINAL=urxvt
export PATH=$PATH:~/bin

#- - - - - - - - - - - - - - - - - - -#
#                             general #
#- - - - - - - - - - - - - - - - - - -#

# if not interactive, don't do anything
[[ $- != *i* ]] && return

# git prompt
source ~/.bash-git-prompt.sh

# directory colors
eval `dircolors ~/.dircolors`

# aliases
[[ -f ~/.alias ]] && . ~/.alias

# completion
[[ -f /etc/profile.d/bash_completion.sh ]] && . /etc/profile.d/bash_completion.sh

# set caps-lock as another ctrl
setxkbmap -option ctrl:nocaps

# enables autocd, interpret dir_name as cd dir_name
shopt -s autocd

# enables vi mode
set -o vi

# gam setup
gam() { "$HOME/bin/gam/gam" "$@" ; }

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

PROMPT_COMMAND=prompt

# build prompt
prompt() {
  # left prompt
  PS1="\[\e[32m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[33m\]\`parse_git_branch\`\[\e[m\] "$'\u2771 '

  # right prompt
  width=$(expr `tput cols` - 1)
  printf "%${width}s`tput cr`" $(pwd | sed "s:^$HOME:~:")
}
