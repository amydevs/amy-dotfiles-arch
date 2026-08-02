#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Customization
feh --no-fehbg --bg-fill '/home/ayanamy/Pictures/wallpaper.png' &
# xcompmgr &
picom --backend glx &

sxhkd &
dwmblocks &

export XDG_CURRENT_DESKTOP=dwm
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_USE_XINPUT2=1
export QT_SCREEN_SCALE_FACTORS=1.00001
export QT_SCALE_FACTOR=1.5

# Ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
ibus-daemon -drxR &

# Applets
nm-applet &
caffeine start &
dunst &

# Passwords
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO

# Status
# while true; do
# 	xsetroot -name "$(date)"
# 	sleep 2
# done &

exec dwm

