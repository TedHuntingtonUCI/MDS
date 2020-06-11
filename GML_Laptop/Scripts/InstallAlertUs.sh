#!/bin/bash

BASENAME=${0##*/}
SCRIPTDIR=${0%$BASENAME}



echo Install AlertUS
cd "${SCRIPTDIR}/Resources/AlertUs"
installer  -pkg "./alertus-desktop-osx-2.10.01.1727.pkg" -target /
