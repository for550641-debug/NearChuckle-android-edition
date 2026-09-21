#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "$DIR/.." && pwd )"

ARCH="arm64"
BUILD_TYPE="Release"
NDK_PATH="${ANDROID_NDK_HOME:-${ANDROID_NDK_ROOT:-$NDK_HOME}}"

usage() {
    echo "Usage: ./build_android.sh [--arch arm64|arm|x86_64] [--debug|--release] [--ndk /path/to/ndk]"
    echo "  --arch: target architecture (default: arm64)"
    echo "  --ndk: path to Android NDK"
    echo "  --debug: build debug binaries"
    echo "  --release: build release binaries (default)"
    exit 0
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --help|-h)
            usage
            ;;
        --arch)
            ARCH="$2"
            shift 2
            ;;
        --ndk)
            NDK_PATH="$2"
            shift 2
            ;;
        --debug)
            BUILD_TYPE="Debug"
            shift
            ;;
        --release)
            BUILD_TYPE="Release"
            shift
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
done

case "$ARCH" in
    arm64|aarch64)
        ABI="arm64-v8a"
        ;;
    arm|armeabi-v7a)
        ABI="armeabi-v7a"
        ;;
    x86_64)
        ABI="x86_64"
        ;;
    *)
