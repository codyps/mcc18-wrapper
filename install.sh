#!/bin/sh
rmln () {
	stat $1 >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo "file \"$1\" not installed"
		return
	fi

	readlink -q $1 >/dev/null
	if [ $? -eq 0 ]; then
		rm $1
		echo "removed \"$1\""
	else
		echo "file \"$1\" is not the expected symlink"
	fi
}

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
		ln -s $rdir/$f $3/$f
		echo "installed \"$2/$f\" to \"$3/$f\""
	done
elif [ \( $1 = "uninstall" \) -a \( $# -eq 2 \) ]; then
	for f in $files; do
		rmln $2/$f
	done
else
	usage
fi
