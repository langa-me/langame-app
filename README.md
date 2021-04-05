# Langame Flutter

## Installation

```bash
flutter pub get
```

## Usage

### Json

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Emulator

Get your local laptop IP for the client:
```bash
ip a
```

Export emulator data:
```bash
firebase emulators:export ../data
```

Import emulator data:
```bash
firebase emulators:start --import ../data
```
