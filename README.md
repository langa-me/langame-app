# Langame

[![codecov](https://codecov.io/gh/langa-me/langame-app/branch/main/graph/badge.svg?token=4LVXERDQ5U)](https://codecov.io/gh/langa-me/langame-app)

![graph-codecov](https://codecov.io/gh/langa-me/langame-app/branch/main/graphs/sunburst.svg?token=4LVXERDQ5U)

## Development

### Prerequisites

- Please use VSCode (and GitHub Copilot, it increases productivity a lot)
- Firebase CLI
- Google Cloud SDK
- Flutter for Android, iOS, Web
- protoc, protoc-gen-dart, protobufjs

### Usage

See `.vscode/launch.json`

#### Operations

##### Indexes

https://firebase.google.com/docs/firestore/query-data/index-overview?authuser=0#composite_indexes

```bash
firebase deploy --only firestore:indexes
gcloud firestore operations list
gcloud firestore operations describe [OPERATION_NAME]
```

```bash
firebase firestore:indexes > ../firestore.indexes.json
```

##### Data transfer

See https://louis030195/firebase-data

##### Proto gen

```bash
npm install protobufjs -g
# Also install dart & python stuff protoc
```

```bash
wget https://raw.githubusercontent.com/protocolbuffers/protobuf/master/src/google/protobuf/empty.proto -P protos/google/protobuf
wget https://raw.githubusercontent.com/protocolbuffers/protobuf/master/src/google/protobuf/timestamp.proto -P protos/google/protobuf
make proto
```

##### Upgrades

```bash
# Upgrade Flutter
flutter upgrade
# then cmd + shift + r "flutter-version: 2.x.x"
flutter pub global activate protoc_plugin
# Dependencies
flutter pub outdated
# Install
flutter pub upgrade
```

### How to release

1. bump pubspec.yaml version number and version code
2. update changelogs in fastlane (android/fastlane/changelogs and ios/fastlane/Fastfile)
3. commit (x.x.x+x: new features...) & push
4. once CI/CD is done
   1. update langame_version from remote config if you want to force user update (non-backward compatible changes)
5. deploy new Firebase stuff in prod
