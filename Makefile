XCODEFLAGS=-project Thesi.xcodeproj \
	-scheme Thesi \
	-destination 'platform=macOS' \
	DSTROOT=.
FULL_PRODUCT_NAME=Thesi.plugin
BUILT_PRODUCT_DIR=./build/Release/
INSTALL_DIR=~/Library/Application\ Support/MacDown/PlugIns

.PHONY: carthage build test install

carthage:
	carthage update --platform macOS

build:
	xcodebuild $(XCODEFLAGS) | xcpretty

test:
	xcodebuild test $(XCODEFLAGS) -configuration Travis | xcpretty

install: build
	cp -rf $(BUILT_PRODUCT_DIR)$(FULL_PRODUCT_NAME) $(INSTALL_DIR)
