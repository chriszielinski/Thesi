XCODEFLAGS=-project Thesi.xcodeproj \
	-scheme Thesi \
	-destination 'platform=macOS'
FULL_PRODUCT_NAME=Thesi.plugin
BUILT_PRODUCT_DIR=Products/Release/
INSTALL_DIR=~/Library/Application\ Support/MacDown/PlugIns

.PHONY: all carthage build test install

all: carthage build

carthage:
	carthage update --platform macOS

build:
	xcodebuild $(XCODEFLAGS) -configuration Release | xcpretty

test:
	xcodebuild test $(XCODEFLAGS) -configuration Debug | xcpretty
