proto:
	rm -rf lib/protos/*.dart
	protoc --dart_out=. lib/protos/api.proto
