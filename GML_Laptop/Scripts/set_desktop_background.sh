#!/bin/bash

BASENAME=${0##*/}
SCRIPTDIR=${0%$BASENAME}


DESKTOP_PICTURES_FOLDER="/Users/Shared/Desktop Pictures/"
DESKTOP_PICTURE_FILE="UCI.jpg"

if ! [ -e "${DESKTOP_PICTURES_FOLDER}" ] ; then
	/bin/mkdir -p "${DESKTOP_PICTURES_FOLDER}"
fi

/bin/cp "${SCRIPTDIR}/Resources/${DESKTOP_PICTURE_FILE}" "${DESKTOP_PICTURES_FOLDER}"

/bin/chmod r+ugo "${DESKTOP_PICTURES_FOLDER}/${DESKTOP_PICTURE_FILE}"

/usr/bin/profiles install -type configuration -path "${SCRIPTDIR}/Resources/com.apple.desktop.mobileconfig"


exit 0
