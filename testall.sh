#!/bin/bash

TESTFOLDER=./tests
TMPFOLDER=./tmp/
R2DECFOLDER=$1

NODE=$(which node)

TESTS=$(find "$TESTFOLDER" | grep ".json" | sed "s/.json//g")

mkdir "$TMPFOLDER"

for ELEM in $TESTS; do
	NAME=$(basename "$ELEM")
	$NODE $R2DECFOLDER/main.js "$ELEM.json" > "$TMPFOLDER/output.txt" || break
	DIFF=$(diff -u "$TMPFOLDER/output.txt" "$ELEM.output.txt")

	if [ ! -z "$DIFF" ]; then
		echo "[XX]: $NAME"
		echo "$DIFF"
	else
		echo "[OK]: $NAME"
	fi

done

if [ ! "$TMPFOLDER" == "/tmp" ]; then
	rm -rf "$TMPFOLDER"
fi