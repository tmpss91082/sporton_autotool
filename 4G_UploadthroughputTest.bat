@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
echo Test Start>uploadthroughputresult.txt
set /p p="How manny run do you want to test: "
set /p w="How manny threat do you want start simultaneously(max is 3): "
mkdir winscptestscript
set /a qq=1024
set /a e=1048576
set /a a=%qq%*%e%
for /L %%B IN (1,1,%w%) do (
    fsutil file createnew 1Gtest%%B %a%
    move 1Gtest%%B winscptestscript\1Gtest%%B
    echo open ftp://anonymous:anonymous@90.130.70.73/>winscptestscript\winscpscriptup%%B
    echo cd upload>>winscptestscript\winscpscriptup%%B
    echo put winscptestscript\1Gtest%%B*>>winscptestscript\winscpscriptup%%B
    echo start /B winscp.com /script=winscptestscript\winscpscriptup%%B>winscptestscript\winscpstartup%%B.bat
    echo exit>>winscptestscript\winscpstartup%%B.bat)
echo TEST_START_TIME %date% %time%>>uploadthroughputresult.txt
for /L %%A IN (1 ,1 , %p%) do (
    echo !RANDOM!!RANDOM!>winscptestscript\timestamp
    set /p timestamp=<winscptestscript\timestamp
    echo !timestamp!
    echo =============================================================
    echo uploadthroughput test Run%%A starting, Please wait...
    echo run%%A test starting>>uploadthroughputresult.txt
    echo ======================>>uploadthroughputresult.txt
    if %w% == 2 (
        ren winscptestscript\1Gtest1* 1Gtest1!timestamp!
        ren winscptestscript\1Gtest2* 1Gtest2!timestamp!
        start /B winscptestscript\winscpstartup1.bat
        start /B winscptestscript\winscpstartup2.bat
        timeout /t 30 /nobreak >nul)
    if %w% == 3 (
        ren winscptestscript\1Gtest1* 1Gtest1!timestamp!
        ren winscptestscript\1Gtest2* 1Gtest2!timestamp!
        ren winscptestscript\1Gtest3* 1Gtest3!timestamp!
        start /B winscptestscript\winscpstartup1.bat
        start /B winscptestscript\winscpstartup2.bat
        start /B winscptestscript\winscpstartup3.bat
        timeout /t 30 /nobreak >nul)
    if %w% == 1 (
        ren winscptestscript\1Gtest1* 1Gtest1!timestamp!
        start /B winscptestscript\winscpstartup1.bat
        timeout /t 30 /nobreak >nul)
    echo Run%%A test end>>uploadthroughputresult.txt
    echo ======================>>uploadthroughputresult.txt
    taskkill /f /im  WinSCP.exe
    taskkill /f /im  WinSCP.com)
echo TEST_END_TIME %date% %time%>>uploadthroughputresult.txt
rmdir /s /q winscptestscript
del WinSCP.com
del WinSCP.exe
echo =============================================================
echo =============================================================
echo Test Finish...
echo Please check the uploadthroughputresult.txt to the result 
echo Press any key to exit.
pause >nul
exit