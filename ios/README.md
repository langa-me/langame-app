
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

## Apple garbage

Changed Apple Identifier capabilities 
for example and need to update profile 
in certificates repository:

```bash
fastlane match init
```
