
## Zip

```bash
zip release.zip -r Config
gpg --symmetric --cipher-algo AES256 release.zip
rm -rf release.zip Config
```

## Unzip

```bash
gpg --output release.zip --decrypt release.zip.gpg && unzip release.zip && rm -rf release.zip
```
