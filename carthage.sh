#!/bin/bash
export XCODE_XCCONFIG_FILE=$(pwd)/Config.xcconfig
carthage update --platform iOS --cache-builds
