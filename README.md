# Langame

[![codecov](https://codecov.io/gh/langa-me/langame-app/branch/main/graph/badge.svg?token=4LVXERDQ5U)](https://codecov.io/gh/langa-me/langame-app)

![graph-codecov](https://codecov.io/gh/langa-me/langame-app/branch/main/graphs/sunburst.svg?token=4LVXERDQ5U)

## Development

### Running

You should use **Idea IntelliJ** and create at least these configurations:
- Flutter with flavor "dev"
- Flutter with flavor "prod" (but you should not develop in production)

Using CLI:
```bash
flutter devices
```
```bash
flutter run --flavor dev -d [MY_DEVICE]
flutter run --flavor prod -d [MY_DEVICE]
```

### Stripe

```bash
brew install stripe/stripe-cli/stripe
```

```bash
# Premium product
stripe products create \
  --name="Billing Guide: Premium Service" \
  --description="Premium service with extra features"

# Basic product
stripe products create \
  --name="Billing Guide: Basic Service" \
  --description="Basic service with minimum features"

# Premium price
stripe prices create \
-d product=prod_JV1FPZFW99R0Ol \
-d unit_amount=1000 \
-d currency=usd \
-d "recurring[interval]"=month

# Basic price
stripe prices create \
-d product=prod_HGd6W1VUqqXGvr \
-d unit_amount=500 \
-d currency=usd \
-d "recurring[interval]"=month
```

### Proto gen

```bash
npm install protobufjs -g
# Also install dart & python stuff protoc
```

```bash
cd ..
git clone org-856813@github.com:stripe/openapi.git
go get -u github.com/NYTimes/openapi2proto/cmd/openapi2proto
cd langame-app
mkdir -p protos/stripe/protobuf
openapi2proto -spec ../openapi/openapi/spec3.json -out protos/stripe.proto
wget https://raw.githubusercontent.com/protocolbuffers/protobuf/master/src/google/protobuf/empty.proto -P protos/google/protobuf
wget https://raw.githubusercontent.com/protocolbuffers/protobuf/master/src/google/protobuf/timestamp.proto -P protos/google/protobuf
make proto
```

### Upgrades

```bash
flutter upgrade
flutter pub global activate protoc_plugin
```

### How to release

1. bump pubspec.yaml version number and version code
2. update changelogs in fastlane (android/fastlane/changelogs and ios/fastlane/Fastfile)
3. commit (x.x.x+x: new features...) & push
4. once CI/CD is done
   1. update langame_version from remote config if you want to force user update (non-backward compatible changes)
5. deploy new Firebase stuff in prod
