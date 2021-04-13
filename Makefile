LANGAME_WORKER_PATH ?= ${HOME}/Documents/langame-worker

proto:
	rm -rf lib/models/langame/protobuf/langame*pb* \
		${LANGAME_WORKER_PATH}/langame/protobuf/langame*pb* \
#		firebase/functions/src/api/*pb*
	protoc -I protos \
		--dart_out=lib/models \
		--python_out=${LANGAME_WORKER_PATH} \
		langame/protobuf/langame.proto

#		--ts_out=firebase/functions/src \
#		TS protobuf disabled until protobuf is usable with TS

compile_models:
	flutter pub run build_runner watch --delete-conflicting-outputs
