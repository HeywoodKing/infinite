@echo off
set aFile=bak-%DATE:~4,4%%DATE:~9,2%%DATE:~12,2%
set bFile=bak-%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
set cFile=bak-%DATE%

rem cpms_db_20190111160745.dump
set dFile=CPMS_DB_%date:~0,4%_%date:~5,2%_%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%.dump
echo Afile=%aFile%
echo Bfile=%bFile%
echo Cfile=%cFile%
echo Dfile=%dFile%

pause
