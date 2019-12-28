#!/usr/bin/env bash

export BUILD_VERSION="1.4.0-bin-${TIMESTAMP}"
echo "The build version is: ${BUILD_VERSION}"
cd proj/io
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy -no-colors publishLocal publish
cd ../../proj/sbt/
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy -no-colors clean lowerUtils/publishLocal lowerUtils/publish
cd ../../proj/zinc
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy -no-colors clean publishLocal publish
