#!/bin/sh

# --batch to prevent interactive command
# --yes to assume "yes" for questions
gpg --quiet --batch --yes --decrypt --passphrase="$RELEASE_SECRET_PASSPHRASE" \
--output android/release.zip android/release.zip.gpg && cd android && jar xvf release.zip
