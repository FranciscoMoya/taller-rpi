#!/bin/bash --
# -*- coding:utf-8; tab-width:4; mode:shell-script -*-

is_debian () {
	lsb_release -i 2> /dev/null | grep Debian > /dev/null
	return $?
}

file_contents() {
	sed '/^ *#/d;s/#.*//' $1  # remove comments
}

check_debian_depends() {
	if ! is_debian; then
		echo 'WARNING: This is not Debian, dependency checking skipped'
		return 1
	fi

	retval=0

	for line in $(file_contents $1); do
		dpkg -l "$line" 2> /dev/null | grep "^ii" &> /dev/null
		if [ $? -ne 0 ]; then
			echo "Error: missing package: $line"
			retval=1
		fi
	done

	return $retval
}

check_command_depends() {
	retval=0

	for line in $(file_contents $1); do
		if ! type -t $line > /dev/null ; then
			echo "Error: missing command: $line" 1>&2
			retval=1
		fi
	done

	return $retval
}

echo "Checking dependences..."
check_debian_depends DEPENDS
