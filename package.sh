#!/bin/sh -e

# provide sane environment
\unalias -a
PATH="$(getconf PATH)"

SRCDIR="$(cd "$(dirname "$0")" && pwd)"
PRJNAME="${SRCDIR##*/}"

# create debian archive
VERSION=$(git tag --sort=version:refname | tail -n 1)
if [ -z "$VERSION" ]; then
	echo "Error: Version could not be determined." >&2
	exit 1
fi
PKGNAME=${PRJNAME}_${VERSION}_all
cd "$SRCDIR"
mkdir --parents "$PKGNAME/DEBIAN"
trap 'rm --recursive $PKGNAME' EXIT
PREFIX=$PKGNAME/usr ./install.sh
cat <<END >"$PKGNAME/DEBIAN/control"
Package: $PRJNAME
Version: $VERSION
Architecture: all
Depends: php-cli | php5-cli | php7-cli, mariadb-client | mariadb-client-5.5 | mariadb-client-10.0 | mariadb-client-10.1 | mariadb-client-10.3 | mariadb-client-10.4 | mysql-client | mysql-client-5.5 | mysql-client-5.7 | mysql-client-8.0
Description: Change the URL of a WordPress site
Homepage: https://github.com/mskuta/$PRJNAME
Maintainer: Martin Skuta (https://github.com/mskuta)
Priority: optional
Section: utils
END
dpkg-deb --build "$PKGNAME"

exit 0

