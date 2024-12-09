#!/bin/bash

set -e

if [ "$#" -ne 4 ]; then
    echo "Použití: $0 <ARCHITECTURE> <BUILD_TYPE> <SOURCE_DIR> <DESTINATION_DIR>"
    exit 1
fi

ARCHITECTURE="$1"
BUILD_TYPE="$2"
SOURCE_DIR="$3"
DESTINATION_DIR="$4"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$ARCHITECTURE" = "aarch64" ]; then
    TOOLCHAIN_ARG="-DCMAKE_TOOLCHAIN_FILE=$SCRIPT_DIR/aarch64.cmake"
else
    TOOLCHAIN_ARG=""
fi

BUILD_DIR="build/$ARCHITECTURE/$DESTINATION_DIR/$BUILD_TYPE"
mkdir -p "$BUILD_DIR"

cmake -S "$SOURCE_DIR" \
    -B "$BUILD_DIR" \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    $TOOLCHAIN_ARG
