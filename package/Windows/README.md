# Log4j detection script

This is ready to use script to detect Log4j in Java processes on Windows systems.

This will only check the presence of Log4j, you'll have to check whether it is vulnerable version or not by yourself.

This package contains YARA (https://github.com/VirusTotal/yara) executable, built for Win64, msvcr100.dll library necessary for running YARA, and the rule file (log4j.yar).

## How to scan?

1. Copy all files in this folder to target computer.
2. Run scan.bat
3. Check scan_results.txt. If Log4j was found, then this file will contain PID of the process that uses Log4j. Otherwise, this file would contain "Nothing found".

For example, if scan_results.txt contains string
``log4j_memory 12162``
than process with PID of 12162 is a Java process that uses Log4j library.
You can that use the command 
``wmic path win32_process get processid,commandline /format:csv | findstr 12162``
to get command line of this Java process to find which application uses this library and if it has ``formatMsgNoLookups`` property set (see "Mitigations" section).




