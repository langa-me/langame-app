
# Usage

## Generate keystore

```bash
export MY_KEY_PASSWORD="MY_PASS"
```

### Release

```bash
keytool -genkey -v -keystore release.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
```

### Debug

```bash
keytool -genkey -v -keystore ~/.android/langame-dev-debug.keystore -storepass "$MY_KEY_PASSWORD" -alias langame-dev -keypass "$MY_KEY_PASSWORD" -keyalg RSA -keysize 2048 -validity 10000
```

### Get fingerprints

```bash
 keytool -list -v -alias langame-dev -keystore ~/.android/langame-dev-debug.keystore -storepass "$MY_KEY_PASSWORD" -keypass "$MY_KEY_PASSWORD"
```

### Verify apk signature

```bash
jarsigner -verify -verbose -certs my_application.apk
```

## Zip

```bash
zip release.zip service_account_key.json app/langame.jks key.properties app/google-services.json
gpg --symmetric --cipher-algo AES256 release.zip
rm -rf release.zip service_account_key.json app/langame.jks key.properties app/google-services.json
```

## Unzip

```bash
gpg --output release.zip --decrypt release.zip.gpg && jar xvf release.zip && rm -rf release.zip
```

