#!/bin/sh -e

# provide sane environment 
\unalias -a
PATH="$(getconf PATH)"

SRCDIR="$(cd "$(dirname "$0")" && pwd)"
PRJNAME="${SRCDIR##*/}"

# set installation root directory
PREFIX="${PREFIX:-/usr/local}"

# install program
DSTDIR="$PREFIX/bin"
mkdir --parents "$DSTDIR"
for SRCFILE in *.bash; do
	DSTFILE="${SRCFILE%%.*}"
	printf '#!/usr/bin/env bash\n\n' | cat - "$SRCDIR/$SRCFILE" >"$DSTDIR/$DSTFILE"
	chmod 755 "$DSTDIR/$DSTFILE"
done

# install docs
DSTDIR="$PREFIX/share/doc/$PRJNAME"
mkdir --parents "$DSTDIR"
for SRCFILE in [A-Z]*; do
	DSTFILE="$SRCFILE"
	cp "$SRCDIR/$SRCFILE" "$DSTDIR/$DSTFILE"
	chmod 644 "$DSTDIR/$DSTFILE"
done

exit 0

