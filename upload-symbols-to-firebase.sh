#!/bin/bash

# Script that Uploads Symbols (dSYMs) to Firebase
# Writen by Vincent Liao

# -k={CRASHLYTICS-API-KEY} or --api-key={CRASHLYTICS-API-KEY}
# -t={CRASHLYTICS-DEVELOPER-TOKEN} or --dev-token={CRASHLYTICS-DEVELOPER-TOKEN}
# -f={PATH_TO_DSYMS_ARCHIVE} or -filepath={PATH_TO_DSYMS_ARCHIVE}

# Example usage:
# ./upload_dsyms_to_firebase.sh -k=123456 -t=111111 -f=/Users/Builder/artifacts.zip

# getopts code sourced from: https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash

for i in "$@"
do
case $i in
    -k=*|--api-key=*)
    APIKEY="${i#*=}"
    shift # past argument=value
    ;;
    -t=*|--dev-token=*)
    DEVTOKEN="${i#*=}"
    shift # past argument=value
    ;;
    -b=*|--bundle-id=*)
    BUNDLEID="${i#*=}"
    shift # past argument=value
    ;;
    -f=*|--filepath=*)
    FILEPATH="${i#*=}"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

echo "Crashlytics API Key: $APIKEY"
echo "Crashlytics Developer Token: $DEVTOKEN"
echo "Bundle ID: $BUNDLEID"
echo "Path to dSYMs Archive: $FILEPATH"

curl 'https://cm.crashlytics.com/api/v3/platforms/ios/code_mappings' \
	-H "X-CRASHLYTICS-API-KEY: $APIKEY" \
	-H "X-CRASHLYTICS-DEVELOPER-TOKEN: $DEVTOKEN" \
	-F "project[identifier]=$BUNDLEID" \
	-F 'code_mapping[type]=dsym' \
	-F "code_mapping[file]=@$FILEPATH" \
	--compressed \
	--verbose