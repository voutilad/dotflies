# lock after 5 mins plz
xidle -timeout 300 &

# sometimes i like things a little prettier
if [ -x /usr/local/bin/picom ]; then
	picom -b --inactive-dim 0.1
fi

# i like my dog
if [ -x /usr/local/bin/feh ] ; then
	feh --bg-fill ~/Pictures/Maple-full.png
fi

# i like to know when my laptop is gonna die
if [ -x /usr/local/bin/xbattmon  ] ; then
	xbattmon -t3 -p left &
fi

# dbus...lame
if [ -x /usr/local/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
        eval `dbus-launch --sh-syntax --exit-with-x11`
fi

# love me cwm
cwm
