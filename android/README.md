
# Usage

```bash
zip release.zip service_account_key.json app/langame.jks key.properties app/google-services.json
gpg --symmetric --cipher-algo AES256 release.zip
rm -rf release.zip service_account_key.json app/langame.jks key.properties app/google-services.json
```

## Unzip

```bash
gpg --output release.zip --decrypt release.zip.gpg && jar xvf release.zip && rm -rf release.zip
```
