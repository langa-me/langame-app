LANGAME_WORKER_PATH ?= ../langame-worker
FUNCTIONS_PATH ?= ./functions
GOOGLE_PROTO_SUBPATH ?= google/protobuf
LANGAME_PROTO_SUBPATH ?= langame/protobuf

proto: ## [Local development] Build protobuf stubs.
	protoc -I protos --dart_out=./lib/models langame/protobuf/langame.proto protos/google/protobuf/*.proto

	mkdir -p ${FUNCTIONS_PATH}/lib/${GOOGLE_PROTO_SUBPATH}
	mkdir -p ${FUNCTIONS_PATH}/src/${GOOGLE_PROTO_SUBPATH}
	pbjs -t static-module -w commonjs -o ${FUNCTIONS_PATH}/lib/${GOOGLE_PROTO_SUBPATH}/timestamp.js \
	protos/${GOOGLE_PROTO_SUBPATH}/timestamp.proto && \
	pbts -o ${FUNCTIONS_PATH}/src/${GOOGLE_PROTO_SUBPATH}/timestamp.d.ts ${FUNCTIONS_PATH}/lib/${GOOGLE_PROTO_SUBPATH}/timestamp.js

	mkdir -p ${FUNCTIONS_PATH}/lib/${GOOGLE_PROTO_SUBPATH}
	mkdir -p ${FUNCTIONS_PATH}/src/${GOOGLE_PROTO_SUBPATH}
	pbjs -t static-module -w commonjs -o ${FUNCTIONS_PATH}/lib/${GOOGLE_PROTO_SUBPATH}/any.js \
	protos/${GOOGLE_PROTO_SUBPATH}/any.proto && \
	pbts -o ${FUNCTIONS_PATH}/src/${GOOGLE_PROTO_SUBPATH}/any.d.ts ${FUNCTIONS_PATH}/lib/${GOOGLE_PROTO_SUBPATH}/any.js

	mkdir -p ${FUNCTIONS_PATH}/lib/${LANGAME_PROTO_SUBPATH}
	mkdir -p ${FUNCTIONS_PATH}/src/${LANGAME_PROTO_SUBPATH}
	pbjs -t static-module -w commonjs -o ${FUNCTIONS_PATH}/lib/${LANGAME_PROTO_SUBPATH}/langame.js \
	protos/${LANGAME_PROTO_SUBPATH}/langame.proto && \
	pbts -o ${FUNCTIONS_PATH}/src/${LANGAME_PROTO_SUBPATH}/langame.d.ts ${FUNCTIONS_PATH}/lib/${LANGAME_PROTO_SUBPATH}/langame.js

icon: ## [Local development] Update files with new icon.
	flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-main.yaml

android_sync: ## [Local development] Android configuration.
	cp android/app/src/prod/AndroidManifest.xml android/app/src/dev/AndroidManifest.xml
	cp android/app/src/prod/AndroidManifest.xml android/app/src/debug/AndroidManifest.xml
	cp android/app/src/prod/AndroidManifest.xml android/app/src/profile/AndroidManifest.xml

deploy_web: ## [Local development] Manually deploy Firebase hosting dev.
	firebase use langame-dev
	$(eval VERSION=$(shell sh -c "cat pubspec.yaml | yq e '.version' -" | sed 's/+/./g'))
	flutter build web --release
	firebase hosting:channel:deploy "${VERSION}" --expires 7d --only dev-app


.PHONY: help

help: # Run `make help` to get help on the make commands
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'