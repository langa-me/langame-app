LANGAME_WORKER_PATH ?= ../langame-worker

proto:
	protoc -I protos --dart_out=./lib/models --python_out=${LANGAME_WORKER_PATH} \
	langame/protobuf/langame.proto protos/stripe/protobuf/stripe.proto protos/google/protobuf/empty.proto

compile_models:
	flutter pub run build_runner watch --delete-conflicting-outputs
