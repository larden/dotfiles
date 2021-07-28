# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# run X on tty1
if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
  XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 exec startx
fi
