# Log4j detection script

This is ready to use script to detect Log4j in Java processes on Linux systems.

This will only check the presence of Log4j, you'll have to check whether it is vulnerable version or not by yourself.

You will need to install YARA (https://github.com/VirusTotal/yara) before using this script.

## How to scan?

1. Copy all files in this folder to the target computer.
2. Run scan.sh
3. Check scan_results.txt. If Log4j was found, then this file will contain PID of the process that uses Log4j. Otherwise, this file would contain "Nothing found".

For example, if scan_results.txt contains string
``log4j_memory 12162``
than process with PID of 12162 is a Java process that uses Log4j library.
