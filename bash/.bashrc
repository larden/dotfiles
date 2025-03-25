# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# If system-wide bashrc exists, bring it in
test -r /etc/bash.bashrc &&
      . /etc/bash.bashrc

# ignore python bytecode, vim swap files
FIGNORE=".pyc:.swp:.swa:.swo"

# history related variables
export HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
export HISTFILESIZE=50000
export HISTSIZE=50000
export HISTIGNORE='ls:bg:fg:history'
export PROMPT_COMMAND='history -a'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# -----------------------------------------------------------------------------
# Pager/editor settings
# -----------------------------------------------------------------------------

HAVE_GVIM=$(command -v gvim)
HAVE_VIM=$(command -v vim)

# editor
test -n "$HAVE_VIM" &&
EDITOR=vim ||
EDITOR=vi
export EDITOR

# pager
if test -n "$(command -v less)"; then
  PAGER="less -FirSwX"
  MANPAGER="less -FirSwX"
else
  PAGER=more
  MANPAGER=more
fi

if test -n "$HAVE_VIM"; then
        export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
fi

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[[ -n "$PS1" ]] && [[ -s "$BASE16_SHELL/profile_helper.sh" ]] && source "$BASE16_SHELL/profile_helper.sh"
base16_default-dark

# load color codes
test -r ~/.bash/color_codes &&
      . ~/.bash/color_codes

# set colors according to username
if [ "$LOGNAME" = "root" ]; then
  COLOR1="${RED}"
  COLOR2="${BROWN}"
  P="#"
else
  COLOR1="${LIGHT_GREEN}"
  COLOR2="${BROWN}"
  P="\$"
fi

prompt_simple() {
  
  unset PROMPT_COMMAND
  PS1="[\u@\h:\w] ${P} "
  PS2="${P} "

}

jobscount() {
	local stopped='$(jobs -s | wc -l | tr -d " ")'
	local running='$(jobs -r | wc -l | tr -d " ")'
	echo -n "${running}r/${stopped}s"
	 }

prompt_color() {

	PS1="${BLUE}[${GREEN}\t${BLUE}][${YELLOW}\u${GREY}@${PURPLE}\h${GREY}:${CYAN}\W${BLUE}][${RED}\j${BLUE}]${BROWN}$P${PS_CLEAR} "
  PS2="${P} "

}

# -----------------------------------------------------------------------------
# Ls and dircolors
# -----------------------------------------------------------------------------
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# if dircolors tool available, set it up
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

for f in ~/.bash/aliases/*
do
  if [ -f $f ]; then
    . $f
  fi
done

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# -----------------------------------------------------------------------------
# Archive extracting function
# -----------------------------------------------------------------------------

extract () {
   if [ -f $1 ] ; then
      case $1 in
         *.tar.bz2)   tar xjf $1      ;;
         *.tar.gz)   tar xzf $1      ;;
         *.bz2)      bunzip2 $1      ;;
         *.rar)      rar x $1      ;;
         *.gz)      gunzip $1      ;;
         *.tar)      tar xf $1      ;;
         *.tbz2)      tar xjf $1      ;;
         *.tgz)      tar xzf $1      ;;
         *.zip)      unzip $1      ;;
         *.Z)      uncompress $1   ;;
         *)         echo "'$1' cannot be extracted via extract()" ;;
      esac
   else
      echo "'$1' is not a valid file"
   fi
}

# -----------------------------------------------------------------------------
# Personal configuration
# -----------------------------------------------------------------------------

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# load fzf bindings and completion
if [ -f /usr/share/fzf/key-bindings.bash ]; then
	. /usr/share/fzf/key-bindings.bash
fi

if [ -f /usr/share/fzf/completion.bash ]; then
	. /usr/share/fzf/completion.bash
fi

# load shenv file - personal configuration
test -r ~/.bash/shenv &&
      . ~/.bash/shenv


