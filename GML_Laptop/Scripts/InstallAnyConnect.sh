#!/bin/bash

BASENAME=${0##*/}
SCRIPTDIR=${0%$BASENAME}

echo Install anyconnect
cd "${SCRIPTDIR}/Resources/AnyConnect"
installer  -pkg "./AnyConnect.pkg" -target /
