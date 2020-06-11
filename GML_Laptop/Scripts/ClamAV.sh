#!/bin/bash

BASENAME=${0##*/}
SCRIPTDIR=${0%$BASENAME}



cp  "${SCRIPTDIR}"/Resources/ClamAV/clamav.conf /etc/newsyslog.d
cp  "${SCRIPTDIR}"/Resources/ClamAV/*.plist /Library/LaunchDaemons
