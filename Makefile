.PHONY: build

build:
	xcodebuild -project ResolveAlias.xcodeproj DSTROOT=/tmp/ResolveAlias OTHER_LDFLAGS=-Wl,-headerpad_max_install_names -configuration Release install
test:
	xcodebuild -project ResolveAlias.xcodeproj -scheme ResolveAliasTest test
