
# Usage

```bash
zip release.zip service_account_key.json langame.keystore key.properties google-services.json
gpg --symmetric --cipher-algo AES256 release.zip
rm -rf release.zip service_account_key.json langame.keystore key.properties google-services.json
```

## Unzip

```bash
gpg --output release.zip --decrypt release.zip.gpg && jar xvf release.zip
mv google-services.json ../android/app
```
