#- - - - - - - - - - - - - - - - - - -#
#                           variables #
#- - - - - - - - - - - - - - - - - - -#

export TERM=rxvt-unicode-256color
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

#- - - - - - - - - - - - - - - - - - -#
#                            ssh keys #
#- - - - - - - - - - - - - - - - - - -#

# ssh-agent setup
eval $(ssh-agent) >/dev/null 2>&1

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
