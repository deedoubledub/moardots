#- - - - - - - - - - - - -#
#               variables #
#- - - - - - - - - - - - -#

export EDITOR=vim

# if not interactive, don't do anything
[[ $- != *i* ]] && return

#- - - - - - - - - - - - -#
#                  prompt #
#- - - - - - - - - - - - -#

PROMPT_COMMAND=prompt

# build prompt
prompt() {
  # git prompt
  source ~/.bash-git-prompt.sh

  # left prompt
  PS1="\[\e[32m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[33m\]\`parse_git_branch\`\[\e[m\] "$'\u2771 '

  # right prompt
  printf "%`tput cols`s`tput cr`" $(pwd | sed "s:^$HOME:~:")
}
