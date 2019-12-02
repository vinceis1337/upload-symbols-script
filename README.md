# upload-symbols-script
Uploads the symbols (dSYMs) for your build. This script is *nix compatible whereas the Crashlytics upload-symbols is not.

# Instructions

In order to use this script, you must provide the following information

* Crashlytics API Key
* Crashlytics Developer Token
* Path to the compressed dSYMs

The API Key and Developer Token can be easily obtained by uploading a file through the "Upload missing required dSYMs" screen located under your dSYMs tab (next to the Dashboard tab). 

Monitor your internet traffic (using something like Chrome developer console) and look for an outgoing response which will have both the key and token.
