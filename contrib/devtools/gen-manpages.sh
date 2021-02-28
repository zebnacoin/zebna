#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

ZEBNAD=${ZEBNAD:-$BINDIR/zebnad}
ZEBNACLI=${ZEBNACLI:-$BINDIR/zebna-cli}
ZEBNATX=${ZEBNATX:-$BINDIR/zebna-tx}
ZEBNAQT=${ZEBNAQT:-$BINDIR/qt/zebna-qt}

[ ! -x $ZEBNAD ] && echo "$ZEBNAD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
ZEBNAVER=($($ZEBNACLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for zebnad if --version-string is not set,
# but has different outcomes for zebna-qt and zebna-cli.
echo "[COPYRIGHT]" > footer.h2m
$ZEBNAD --version | sed -n '1!p' >> footer.h2m

for cmd in $ZEBNAD $ZEBNACLI $ZEBNATX $ZEBNAQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${ZEBNAVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${ZEBNAVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
