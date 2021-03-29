define MAC
To run a OSX Docker container, run the following:

docker run -it \
	--device /dev/kvm \
	-p 50922:10022 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e "DISPLAY=${DISPLAY:-:0.0}" \
	-e RAM=4 \
	-e CORES=4 \
	sickcodes/docker-osx:latest

docker run --name macos --volumes-from agitated_hoover -e CORES=4 -e RAM=8 -d sickcodes/docker-osx:latest

endef
export MAC
proto:
	rm -rf lib/api/api.pb*
	protoc --dart_out=lib api/api.proto
	cp api/api.proto firebase/functions
	sed -i '4 i //GENERATED, INSTEAD LOOK AT /api' firebase/functions/api.proto

mac:
	@echo "$$MAC"

compile_models:
	flutter pub run build_runner watch --delete-conflicting-outputs
