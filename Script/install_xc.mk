# install_xc.mk

INSTALL_PATH 		?= $(HOME)/local/Frameworks

INSTALL_PATH_MACOS	= $(INSTALL_PATH)/macos
INSTALL_PATH_IOS	= $(INSTALL_PATH)/iphoneos
INSTALL_PATH_IOSSIM	= $(INSTALL_PATH)/iphonesimulator

all: pack_os
	echo "done"

pack_os: install_osx 
	(cd $(HOME)/Library/Frameworks ; rm -rf $(PROJECT_NAME).xcframework)
	xcodebuild -create-xcframework \
	  -framework $(INSTALL_PATH_MACOS)/$(PROJECT_NAME).framework \
	  -output $(HOME)/Library/Frameworks/$(PROJECT_NAME).xcframework

install_osx: dummy
	xcodebuild archive \
	  -scheme $(PROJECT_NAME)\
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(INSTALL_PATH_MACOS) \
	  SKIP_INSTALL=NO \
	  DSTROOT=/ \
	  ONLY_ACTIVE_ARCH=NO

dummy:

