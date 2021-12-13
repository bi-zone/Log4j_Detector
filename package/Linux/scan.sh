#!/bin/sh

command -v yara > /dev/null 2> /dev/null
if [ $? -eq 0 ]; then
	echo 'Start scan'

	ps aux > scan_processes.txt
	> scan_results.txt

	ps -eo pid,comm | grep -i java | grep -Eo '[0-9].*' | cut -d ' ' -f 1 | xargs -I '{}' yara log4j.yar '{}' >> scan_results.txt 2> scan_errors.txt
	if [ ! -s scan_results.txt ]; then
		echo 'Nothing found' >> scan_results.txt
	fi

	echo 'Stop scan'
else
	echo 'yara not found, please install yara:'
	echo ' apt-get install yara'
	echo 'or'
	echo ' yum install yara'
	exit 1
fi
