#!/bin/bash

BASENAME=${0##*/}
SCRIPTDIR=${0%$BASENAME}


echo "Making sure home directories are created"

/usr/sbin/createhomedir -c

for user in /Users/* ; do
	if [ -d "${user}/Library/Preferences" ] ; then
		username="$(basename ${user})"
		echo Setting scrollbars to always on for user account  ${username}
		/usr/bin/defaults write  "${user}"/Library/Preferences/.GlobalPreferences.plist AppleShowScrollBars -string "Always"
		#/usr/bin/defaults write  "${user}"/Library/Preferences/.GlobalPreferences.plist _HIHideMenuBar -int 1
		echo "changing ownership from root back to user of .GlobalPreferences.plist"
		/usr/sbin/chown "${username}" "${user}"/Library/Preferences/.GlobalPreferences.plist
		echo Supressing Required Data Notice
		/usr/bin/defaults write  "${user}"/Library/Preferences/com.microsoft.autoupdate2.plist AcknowledgedDataCollectionPolicy -string "RequiredDataOnly"

		cp "${SCRIPTDIR}/Resources/com.apple.dock.plist" "${user}"/Library/Preferences/

		#Safari
		cp "${SCRIPTDIR}/Resources/Bookmarks.plist" "${user}"/Library/Safari/
		cp "${SCRIPTDIR}/Resources/com.apple.Safari.plist" "${user}"/Library/Containers/com.apple.Safari/Data/Library/Preferences/

		#Chrome
		mkdir "${user}/Library/Application Support/Google/Chrome/Default"
		cp "${SCRIPTDIR}/Resources/Chrome/Bookmarks" "${user}/Library/Application Support/Google/Chrome/Default"
		touch "${user}/Library/Application Support/Google/Chrome/First Run"
		cp "${SCRIPTDIR}/Resources/Chrome/Google Chrome Master Preferences" "${user}/Library/Google"
		cp "${SCRIPTDIR}/Resources/Chrome/Preferences" "${user}/Library/Application Support/Google/Chrome"

		/usr/sbin/chown -R "${username}" "${user}"/Library/Preferences/*

#		echo Copy desktop links
#		cp  "${SCRIPTDIR}/Resources/UC Irvine Health.webloc" "${user}"/Desktop
		#cp  "${SCRIPTDIR}/Resources/VA Long Beach Healthcare System.webloc" "${user}"/Desktop
#		cp  "${SCRIPTDIR}/Resources/Grunigen Medical Library.webloc" "${user}"/Desktop
#		chown -R "${username}" "${user}"/Desktop/*.webloc

#		echo Copy Firefox profile
#		cp  -pr "${SCRIPTDIR}/Resources/Firefox" "${user}/Library/Application Support"
#		chown -R "${username}" "${user}/Library/Application Support/Firefox"
	fi

done

cp "${SCRIPTDIR}/Resources/com.apple.dock.plist" "/System/Library/User Template/English.lproj/Library/Preferences/"
/usr/bin/defaults write  /Library/Preferences/.GlobalPreferences.plist AppleShowScrollBars -string "Always"

#copy firefox enterprise preferences
mkdir "/Applications/Firefox.app/Contents/Resources/distribution"
cp "${SCRIPTDIR}/Resources/policies.json" "/Applications/Firefox.app/Contents/Resources/distribution"


echo Remove AnyConnect startup window
rm -rf /Library/LaunchDaemons/com.cisco.anyconnect.gui.plist
echo Stop Cisco AnyConnect popup
#/usr/bin/defaults write  /Library/LaunchAgents/com.cisco.anyconnect.gui.plist RunAtLoad -int 0
rm -rf /Library/LaunchAgents/com.cisco.anyconnect.gui.plist

echo installing Homebrew
#mkdir /usr/local/bin
#mkdir /usr/local/lib
#export PATH="/usr/local/bin:$PATH"
#export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
mkdir /Users/Shared/.homebrew
cd /Users/Shared/.homebrew
curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /Users/Shared/.homebrew
#git clone https://github.com/Homebrew/linuxbrew.git /Users/Shared/.homebrew

chgrp -R staff /Users/Shared/.homebrew
chmod -R 775 /Users/Shared/.homebrew

export PATH="/Users/Shared/.homebrew/bin:$PATH"
export LD_LIBRARY_PATH="/Users/Shared/.homebrew/lib:$LD_LIBRARY_PATH"
#cp homebrew/bin/brew /usr/local/bin
#cp -pr homebrew/Library /usr/local

echo installing clamav
su - gml -c  "/Users/Shared/.homebrew/bin/brew install ClamAV && sed s/Example/#Example/ /Users/Shared/.homebrew/etc/clamav/freshclam.conf.sample > /Users/Shared/.homebrew/etc/clamav/freshclam.conf && /Users/Shared/.homebrew/bin/freshclam && mkdir /Users/Shared/.homebrew/var/run/clamav"
#cp /Users/Shared/.homebrew/etc/clamav/freshclam.conf.sample /Users/Shared/.homebrew/etc/clamav/freshclam.conf
#cp /usr/etc/freshclam.conf.sample /usr/local/etc/freshclam.conf

#/Users/Shared/.homebrew/bin/freshclam
#to scan run /Users/Shared/.homebrew/bin/clamscan
#echo installing Homebrew
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
exit 0
