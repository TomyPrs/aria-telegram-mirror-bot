#!/bin/bash

# To set a different value other than default(5), remove `#` from below line and replace the value
MAX_CONCURRENT_DOWNLOADS=15
TMP_DIR=tmp
SERVICE_ACC="$TMP_DIR/accounts/*.json"
CONST_FILE="$TMP_DIR/.constants.js"
CREDS_JSON="$TMP_DIR/client_secret.json"

# Check if bot is deployed to heroku
if [[ -n $DYNO ]]; then

    if [[ -n $CREDS_REPO ]]; then
        echo "Creds repo Detected, Clonning.."
        git clone "$CREDS_REPO" $TMP_DIR
    else
        echo "You need provided CREDS REPO in repo secret! exit.."
        exit 0
        rm -rf "$TMP_DIR"
    fi

    if compgen -G $SERVICE_ACC > /dev/null; then
    echo "Service account Files exist"
    cp -r "$TMP_DIR/accounts" "$(pwd)/accounts"
    fi

    if [[ -f $CREDS_JSON ]]; then
        echo "Credentials file detected.. Moving.."
        mv -v tmp/client_secret.json "$(pwd)/client_secret.json"
    fi

    if [[ -f $CONST_FILE ]]; then
        echo "$(pwd)/ $(pwd)/out/" | xargs -n 1 cp -v "$TMP_DIR/.constants.js"
        echo "Bot configuration set.."
    else
        echo "Read heroku deploy properly.."
        exit 0
    fi

    rm -rf $TMP_DIR; echo "Clearing $TMP_DIR"
fi

if [[ -n $MAX_CONCURRENT_DOWNLOADS ]]; then
	sed -i'' -e "/max-concurrent-downloads/d" "$(pwd)/aria.conf"
	echo -e "max-concurrent-downloads=$MAX_CONCURRENT_DOWNLOADS" >> "$(pwd)/aria.conf"
fi

sed -i'' -e "/bt-tracker=/d" "$(pwd)/aria.conf"
tracker_list=`curl -Ns https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt | awk '$1' | tr '\n' ',' | cat`
echo -e "bt-tracker=$tracker_list" >> "$(pwd)/aria.conf"

# Remove the .bak file got created from above sed
test -f $(pwd)/aria.conf-e && rm $(pwd)/aria.conf-e

aria2c --conf-path=aria.conf
echo "Aria2c daemon started"

# Only start the bot if deployed to heroku, as in local the start command might be different for development
if [[ -n $DYNO ]]; then
	npm start
fi