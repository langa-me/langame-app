proto:
	rm -rf lib/api/api.pb*
	protoc --dart_out=lib api/api.proto
	cp api/api.proto firebase/functions
	sed -i '4 i //GENERATED, INSTEAD LOOK AT /api' firebase/functions/api.proto
