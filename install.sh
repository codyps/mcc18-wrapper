#!/bin/sh

usage () {
	echo "usage: $0 install <from dir> <to dir>" >/dev/stderr
	echo "       $0 uninstall <from dir>" >/dev/stderr
	exit 1
}

files="bin/mcc18 bin/mplink bin/mplib mpasm/mpasm"

if [ $# -lt 1 ]; then
	usage
fi

if [ \( $1 = "install" \) -a \( $# -eq 3 \) ]; then
	rdir=`cd $2; pwd -P`
	for f in $files; do
		install $rdir/$f $3/$f
		echo "installed \"$2/$f\" to \"$3/$f\""
	done
elif [ \( $1 = "uninstall" \) -a \( $# -eq 2 \) ]; then
	for f in $files; do
		rm $2/$f
	done
else
	usage
fi
