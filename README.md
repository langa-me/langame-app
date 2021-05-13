# Langame

## Development

You should use **Idea IntelliJ** and create at least these configurations:
- Flutter with flavor "dev"
- Flutter with flavor "prod" (but you should not develop in production)

Using CLI:
```bash
flutter run --flavor dev
flutter run --flavor prod
```

### Json

For using models Dart models:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner watch --delete-conflicting-outputs
```

### How to release

1. bump pubspec.yaml version number and version code
2. update changelogs in fastlane (android/fastlane/changelogs and ios/fastlane/Fastfile)
3. commit & push
4. once CI/CD is done, deploy new Firebase stuff in prod, click release new version in app stores
