# Langame

## Development

You should use **Idea IntelliJ** and create at least these configurations:
- Flutter with flavor "dev"
- Flutter with flavor "prod" (but you should not develop in production)

### Json

For using models Dart models:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner watch --delete-conflicting-outputs
```

