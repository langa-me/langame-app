#!/bin/sh

# --batch to prevent interactive command
# --yes to assume "yes" for questions
gpg --quiet --batch --yes --decrypt --passphrase="$RELEASE_SECRET_PASSPHRASE" \
--output release.zip release.zip.gpg && jar xvf release.zip && cd -
