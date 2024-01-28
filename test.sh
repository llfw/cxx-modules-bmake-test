#! /bin/sh

MAKE="make -m $PWD/mk"

set -e

cd test1

${MAKE} depend
${MAKE}

