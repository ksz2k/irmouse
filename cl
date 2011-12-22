#!/bin/bash

# makes ChangeLog from CVS logs and edits it :)

KSZ_NAME="Krzysiek Szczuka <kszczuka@gmail.com>"

# cvs2cl options
OPCJE="--fsf"

cvs2cl $OPCJE $@ -f ChangeLogb

sed -e "s/ksz/${KSZ_NAME}/g" \
	-e "s/v_00_40/v_00_04/g" \
	-e "s/v_00_50/v_00_05/g" \
	ChangeLogb > ChangeLog
rm ChangeLogb
