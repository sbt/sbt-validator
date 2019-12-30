#!/usr/bin/env bash

set -e

export BUILD_VERSION="1.4.0-bin-${TIMESTAMP}"
echo "The build version is: ${BUILD_VERSION}"
cd proj/io
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy \
  clean "set ThisBuild/version := \"1.4.0-SNAPSHOT\"" test
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy \
  clean publishLocal publish

cd ../../proj/sbt/
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy \
  clean "set ThisBuild/version := \"1.4.0-SNAPSHOT\"" "lowerUtils/test"
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy \
  clean lowerUtils/publishLocal lowerUtils/publish

cd ../../proj/zinc/
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy \
  clean "set ThisBuild/version := \"1.4.0-SNAPSHOT\"" test
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy \
  clean publishLocal publish

cd ../../proj/librarymanagement/
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy \
  clean "set ThisBuild/version := \"1.4.0-SNAPSHOT\"" test
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy \
  clean publishLocal publish

cd ../../proj/sbt/
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy \
  clean "set ThisBuild/version := \"1.4.0-SNAPSHOT\"" \
  "publishLocal; mainSettingsProj/test ;safeUnitTests ;otherUnitTests;" \
  "scripted"
sbt -Dsbt.sbtbintray=false -Dsbt.build.localmaven=${LOCAL_MAVEN} -Dsbt.build.version=${BUILD_VERSION} -sbt-dir $WORKSPACE/.sbt -ivy $WORKSPACE/.ivy \
  clean upperModules/publishLocal upperModules/publish
