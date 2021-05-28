LANGAME_WORKER_PATH ?= ../langame-worker
FUNCTIONS_PATH ?= firebase/functions

proto:
	protoc -I protos --dart_out=./lib/models --python_out=${LANGAME_WORKER_PATH} \
	langame/protobuf/langame.proto protos/stripe/protobuf/stripe.proto protos/google/protobuf/*.proto

	GEN_PATH=google/protobuf
	mkdir -p ${FUNCTIONS_PATH}/lib/${GEN_PATH}
	mkdir -p ${FUNCTIONS_PATH}/src/${GEN_PATH}
	pbjs -t static-module -w commonjs -o ${FUNCTIONS_PATH}/lib/${GEN_PATH}/timestamp.js \
	protos/${GEN_PATH}/timestamp.proto && \
	pbts -o ${FUNCTIONS_PATH}/src/${GEN_PATH}/timestamp.d.ts ${FUNCTIONS_PATH}/lib/timestamp.js

compile_models:
	flutter pub run build_runner watch --delete-conflicting-outputs
