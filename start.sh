#!/bin/bash

# To set a different value other than default(5), remove `#` from below line and replace the value
MAX_CONCURRENT_DOWNLOADS=15

# Check if bot is deployed to heroku
if [[ -n $DYNO ]]; then

	if [[ -n $GIT_TOKEN && -n $CREDS_REPO ]]; then
		echo "Usage of Service Accounts Detected, Clonning git"
		git clone https://"$GIT_TOKEN"@"$CREDS_REPO" tmp/
		mv -v tmp/accounts /app/accounts
		mv -v tmp/credentials.json client_secret.json /app/
		cp tmp/.constants.js /app/
		cp tmp/.constants.js /app/out/.constants.js
		echo "Configuration all set"
		rm -rf tmp/
	else
		exit 0
	fi
fi


if [[ -n $MAX_CONCURRENT_DOWNLOADS ]]; then
	sed -i'' -e "/max-concurrent-downloads/d" $(pwd)/aria.conf
	echo -e "max-concurrent-downloads=$MAX_CONCURRENT_DOWNLOADS" >> $(pwd)/aria.conf
fi

sed -i'' -e "/bt-tracker=/d" $(pwd)/aria.conf
tracker_list=`curl -Ns https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt | awk '$1' | tr '\n' ',' | cat`
echo -e "bt-tracker=$tracker_list" >> $(pwd)/aria.conf

# Remove the .bak file got created from above sed
test -f $(pwd)/aria.conf-e && rm $(pwd)/aria.conf-e

aria2c --conf-path=aria.conf
echo "Aria2c daemon started"

# Only start the bot if deployed to heroku, as in local the start command might be different for development
if [[ -n $DYNO ]]; then
	npm start
fi
