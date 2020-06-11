#!/bin/bash

BASENAME=${0##*/}
SCRIPTDIR=${0%$BASENAME}


echo Install BigFix
cd "${SCRIPTDIR}/Resources/BigFix"
installer  -pkg "./BESAgent-9.5.15.71-BigFix_MacOSX10.14.pkg" -target /
