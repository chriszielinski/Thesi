XCODEFLAGS=-project Thesi.xcodeproj \
	-scheme Thesi \
	-destination 'platform=macOS'
FULL_PRODUCT_NAME=Thesi.plugin
BUILT_PRODUCT_DIR=Products/Release/
INSTALL_DIR=~/Library/Application\ Support/MacDown/PlugIns

.PHONY: all carthage build test install archive

all: carthage build

carthage:
	carthage update --platform macOS

build:
	xcodebuild $(XCODEFLAGS) -configuration Release | xcpretty

test:
	xcodebuild test $(XCODEFLAGS) -configuration Debug | xcpretty

archive:
	cd $(BUILT_PRODUCT_DIR); \
	zip -FSr -1 $(FULL_PRODUCT_NAME).zip $(FULL_PRODUCT_NAME);
	echo "Built distribution zip file: $(BUILT_PRODUCT_DIR)$(FULL_PRODUCT_NAME).zip"
