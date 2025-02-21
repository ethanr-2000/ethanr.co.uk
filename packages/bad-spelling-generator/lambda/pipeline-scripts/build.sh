#!/bin/bash
set -euo pipefail

PROJECT_DIR="$PWD"
BUILD_DIR="$PROJECT_DIR/build"

# Clean up previous build
pnpm rimraf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

pipenv requirements > requirements.txt
mv requirements.txt build/

# Copy source code
pnpm copyfiles -u 1 "src/**/*" "$BUILD_DIR"

pip install \
    --platform manylinux2014_x86_64 \
    --target "$BUILD_DIR" \
    --implementation cp \
    --only-binary=:all: --upgrade \
    -r "$BUILD_DIR/requirements.txt"
