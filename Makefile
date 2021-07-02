LANGAME_WORKER_PATH ?= ../langame-worker
FUNCTIONS_PATH ?= firebase/functions
GOOGLE_PROTO_SUBPATH ?= google/protobuf
STRIPE_PROTO_SUBPATH ?= stripe/protobuf
LANGAME_PROTO_SUBPATH ?= langame/protobuf

proto:
	protoc -I protos --dart_out=./lib/models --python_out=${LANGAME_WORKER_PATH} \
	langame/protobuf/langame.proto protos/stripe/protobuf/stripe.proto protos/google/protobuf/*.proto

	mkdir -p ${FUNCTIONS_PATH}/lib/${GOOGLE_PROTO_SUBPATH}
	mkdir -p ${FUNCTIONS_PATH}/src/${GOOGLE_PROTO_SUBPATH}
	pbjs -t static-module -w commonjs -o ${FUNCTIONS_PATH}/lib/${GOOGLE_PROTO_SUBPATH}/timestamp.js \
	protos/${GOOGLE_PROTO_SUBPATH}/timestamp.proto && \
	pbts -o ${FUNCTIONS_PATH}/src/${GOOGLE_PROTO_SUBPATH}/timestamp.d.ts ${FUNCTIONS_PATH}/lib/${GOOGLE_PROTO_SUBPATH}/timestamp.js

	mkdir -p ${FUNCTIONS_PATH}/lib/${STRIPE_PROTO_SUBPATH}
	mkdir -p ${FUNCTIONS_PATH}/src/${STRIPE_PROTO_SUBPATH}
	pbjs -t static-module -w commonjs -o ${FUNCTIONS_PATH}/lib/${STRIPE_PROTO_SUBPATH}/stripe.js \
	protos/${STRIPE_PROTO_SUBPATH}/stripe.proto && \
	pbts -o ${FUNCTIONS_PATH}/src/${STRIPE_PROTO_SUBPATH}/stripe.d.ts ${FUNCTIONS_PATH}/lib/${STRIPE_PROTO_SUBPATH}/stripe.js

	mkdir -p ${FUNCTIONS_PATH}/lib/${LANGAME_PROTO_SUBPATH}
	mkdir -p ${FUNCTIONS_PATH}/src/${LANGAME_PROTO_SUBPATH}
	pbjs -t static-module -w commonjs -o ${FUNCTIONS_PATH}/lib/${LANGAME_PROTO_SUBPATH}/langame.js \
	protos/${LANGAME_PROTO_SUBPATH}/langame.proto && \
	pbts -o ${FUNCTIONS_PATH}/src/${LANGAME_PROTO_SUBPATH}/langame.d.ts ${FUNCTIONS_PATH}/lib/${LANGAME_PROTO_SUBPATH}/langame.js

icon:
	flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-main.yaml

android_sync:
	cp android/app/src/prod/AndroidManifest.xml android/app/src/dev/AndroidManifest.xml
	cp android/app/src/prod/AndroidManifest.xml android/app/src/debug/AndroidManifest.xml
	cp android/app/src/prod/AndroidManifest.xml android/app/src/profile/AndroidManifest.xml