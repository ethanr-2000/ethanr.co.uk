#!/bin/bash
# pipenv install --deploy --ignore-pipfile

SITE_PACKAGES="$(pipenv --venv)/lib/site-packages/"
BUILD_DIR=$(pwd)/build

# Clean up previous build
pnpm rimraf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Copy the source code
cd src
zip -r9D $BUILD_DIR/ethanr.co.uk-bsg-lambda.zip "*"

# Copy the dependencies
cd $SITE_PACKAGES
ls -l
zip -r9 "$BUILD_DIR/ethanr.co.uk-bsg-lambda.zip" . \
  -x "pip/*" \
  -x "pip-*/**" \
  -x "setuptools/*" \
  -x "wheel/*" \
  -x "wheel-*/**" \
  -x "*/__pycache__/*" \
  -x "*.dist-info/*"
