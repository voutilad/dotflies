#!/bin/sh -x

# jcs's cleanup()
cleanup() {
	echo "cleaning up"
	pkill ssh-agent-card-prompt dbus-daemon redshift picom
	pkill -f "ruby.*sdorfehs-bar"
	rm -f ~/.Xauthority
	rm -f ~/emacs*.core
}
trap cleanup INT TERM QUIT

# lock after 5 mins plz
xset s off
xset dpms 0 0 0
xidle -timeout 300 -program ~/bin/lock &

# sometimes i like things a little prettier
if [ -x /usr/local/bin/picom ]; then
	picom -b --inactive-dim 0.1
fi

# i like my dog
if [ -x /usr/local/bin/feh ] ; then
	feh --bg-fill ~/Pictures/Maple-full.png
fi

# i like to know when my laptop is gonna die
#if [ -x /usr/local/bin/xbattmon  ] ; then
#	xbattmon -t3 -p left &
#fi

# dbus...lame
if [ -x /usr/local/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
        eval `dbus-launch --sh-syntax --exit-with-x11`
fi

# hidpi needs help
export GDK_SCALE=2
export QT_SCALE_FACTOR=2

# firefox help
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1

# love me cwm
# cwm
sdorfehs

# bye!
cleanup
