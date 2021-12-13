# Log4j Detection

You can use this YARA rule to detect the presence of Log4j and then determine whether it is vulnerable to Log4Shell (CVE-2021-44228) or not. If it is, then you can use mitigations listed below to handle this situation.
In the Package folder you can find a collected package which includes YARA executable, the rule file (log4j.yar), and cmd\bash scripts for running it on Windows and Linux systems.

## Scanning for Log4Shell

Log4Shell is a serious remote code execution (RCE) vulnerability in Log4j logging library, which is widely used in Java applications. Because it's often difficult to check whether the specific app is using potentially vulnerable version of this library, we provide this YARA rule to help you with that task. Using it, you can scan the running processes on your systems to check for presense of the Log4j.

## Usage instructions

Use the provided YARA rule to scan running Java processes. If this rule detects Log4j, then its output would be like:

```
Log4j_memory 12162
```

Where 12162 is a process identifier (PID) of process in which Log4j have been found.

### Windows
You can use the folowing commands to scan Windows hosts:

```
tasklist /FO CSV > scan_processes.txt
FOR /F "tokens=2 delims=," %%F in ('tasklist /NH /FO CSV ^| findstr /I java') DO yara64.exe Log4j.yar %%~F >> scan_results.txt
```

### Linux
First, make sure that YARA package is installed on the system. Than you can use folowing command to scan Linux hosts:

```
ps -eo pid,comm | grep -i java | grep -Eo '[0-9].*' | cut -d ' ' -f 1 | xargs -I '{}' yara Log4j.yar '{}' > scan_results.txt
```

## Mitigations

For Log4j version 2.10 or greater, this vulnerability can be mitigated by setting Log4j2.formatMsgNoLookups system property, or by setting environment variable ``LOG4J_FORMAT_MSG_NO_LOOKUPS`` to true (application restart is required).

Versions 2.0-beta9 to 2.10.0 can be mitigated by removing JndiLookup class from the classpath: ``zip -q -d Log4j-core-*.jar org/apache/logging/Log4j/core/lookup/JndiLookup.class``

