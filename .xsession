#!/bin/sh -x

# dear god it's bright in here!
xbacklight =10

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

# etc.
export GTK_THEME=Adwaita:dark
export ENABLE_WASM=1

export XDG_RUNTIME_DIR="/tmp/runtime-$(whoami)"
if ! test -d "${XDG_RUNTIME_DIR}"; then
	mkdir "${XDG_RUNTIME_DIR}"
	chmod 0700 "${XDG_RUNTIME_DIR}"
fi
export _NET_NUMBER_OF_DESKTOPS=6

xprop -root -f _NET_NUMBER_OF_DESKTOPS 32c -set _NET_NUMBER_OF_DESKTOPS 6

# visual indicator of pending death
if [ -x /usr/local/bin/xbattmon  ] ; then
	xbattmon -t3 -p left &
fi

cwm

# bye!
cleanup
