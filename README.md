# Langame

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

### Payments

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

### How to release

1. bump pubspec.yaml version number and version code
2. update changelogs in fastlane (android/fastlane/changelogs and ios/fastlane/Fastfile)
3. commit & push
4. once CI/CD is done, deploy new Firebase stuff in prod, click release new version in app stores
