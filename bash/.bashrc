#polish font
setxkbmap pl

# If system-wide bashrc exists, bring it in
test -r /etc/bash.bashrc &&
      . /etc/bash.bashrc

# ignore python bytecode, vim swap files
FIGNORE=".pyc:.swp:.swa:.swo"

# history related variables
export HISTCONTROL=ignoreboth
export HISTFILESIZE=50000
export HISTSIZE=50000
export HISTIGNORE='ls:bg:fg:history'
export PROMPT_COMMAND='history -a'

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
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

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

# always passed to ls
LS_COMMON="-hBG --color"

# if dircolors tool available, set it up
dircolors="$(type -P gdircolors dircolors | head -1)"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

for f in ~/.bash/aliases/*
do
  if [ -f $f ]; then
    . $f
  fi
done

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
