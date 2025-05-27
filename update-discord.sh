#!/bin/bash


# First close any discord processes

kill $(pgrep -f /usr/share/discord/Discord)
# Next fetch latest stable discord debian package.

wget -O /tmp/discord.deb 'https://discord.com/api/download/stable?platform=linux&format=deb'

#If successful, install package

if [ -e /tmp/discord.deb ]; then
	if [[ -t 0 ]]; then
		sudo dpkg -i /tmp/discord.deb
	else
		pkexec dpkg -i /tmp/discord.deb
	fi
	if [ $? -ne 0 ]; then
		echo Installation failed and aborted.
		return 2
	fi
	# Now run discord if update was a success.
	nohup discord > /dev/null & disown 
	echo Starting Discord...
else
	echo Discord Debian pkg does not exist! Download must have failed.
	return 1
fi

	
#Finish
