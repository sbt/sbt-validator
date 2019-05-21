#!/usr/bin/env bash

export BUILD_VERSION="1.3.0-bin-${TIMESTAMP}"
echo "The build version is: ${BUILD_VERSION}"
cd proj/io
sbt -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy -no-colors publishLocal
cd ../..
