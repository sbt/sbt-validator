#!/usr/bin/env bash
set -e
set -o pipefail
export LANG="en_US.UTF-8"
export HOME="$(pwd)"

#
# dbuild [OPTIONS] config-file [target]
#
if [ "$#" -lt "2" ]
then
  echo "Usage: $0 <dbuild-version> [<dbuild-options>] <dbuild-file> [<dbuild-target>]"
  exit 1
fi
DBUILDVERSION="$1"
shift

echo "dbuild version: $DBUILDVERSION"

if [ ! -d "dbuild-${DBUILDVERSION}" ]
then
  wget "http://repo.typesafe.com/typesafe/ivy-releases/com.typesafe.dbuild/dbuild/${DBUILDVERSION}/tgzs/dbuild-${DBUILDVERSION}.tgz"
  tar xfz "dbuild-${DBUILDVERSION}.tgz"
  rm "dbuild-${DBUILDVERSION}.tgz"
fi

echo "dbuild-${DBUILDVERSION}/bin/dbuild" "${@}"
"dbuild-${DBUILDVERSION}/bin/dbuild" "${@}" 2>&1 | tee "dbuild-${DBUILDVERSION}/dbuild.out"
STATUS="$?"
BUILD_ID="$(grep '^\[info\]  uuid = ' "dbuild-${DBUILDVERSION}/dbuild.out" | sed -e 's/\[info\]  uuid = //')"
echo "The repeatable UUID of this build was: ${BUILD_ID}"
exit "$STATUS"
