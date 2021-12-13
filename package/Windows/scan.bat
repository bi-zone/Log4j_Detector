@ECHO OFF
ECHO Start working
TYPE NUL > scan_errors.txt
TYPE NUL > scan_results.txt
FOR /F "tokens=2 delims=," %%F in ('tasklist /NH /FO CSV ^| findstr /I java') DO (
	ECHO  Found Java process with PID=%%~F
	ECHO  Start scan of %%~F
	yara64.exe log4j.yar %%~F >> scan_results.txt 2>> scan_errors.txt
	ECHO  Complete scan of %%~F
)
FOR %%R in (scan_results.txt) DO IF %%~zR LSS 1 ECHO Nothing found >> scan_results.txt
ECHO End working