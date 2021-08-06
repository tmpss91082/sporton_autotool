@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
echo Test Start>uploadthroughputresult.txt
set /p p="How manny run do you want to test: "
set /p w="How manny threat do you want start simultaneously(max is 3): "
mkdir winscptestscript
set /a qq=1024
set /a e=1048576
set /a a=%qq%*%e%
echo open ftp://anonymous:anonymous@90.130.70.73/>winscptestscript\winscpscript500m
echo cd />>winscptestscript\winscpscript500m
echo get 500MB.zip>>winscptestscript\winscpscript500m
echo exit>>winscptestscript\winscpscript500m
echo open ftp://anonymous:anonymous@90.130.70.73/>winscptestscript\winscpscript200m
echo cd />>winscptestscript\winscpscript200m
echo get 200MB.zip>>winscptestscript\winscpscript200m
echo exit>>winscptestscript\winscpscript200m
echo open ftp://anonymous:anonymous@90.130.70.73/>winscptestscript\winscpscript100m
echo cd />>winscptestscript\winscpscript100m
echo get 1GB.zip>>winscptestscript\winscpscript100m
echo exit>>winscptestscript\winscpscript100m
echo start /B winscp.com /script=winscptestscript\winscpscript200m>winscptestscript\winscpstart200.bat
echo exit>>winscptestscript\winscpstart200.bat
echo start /B winscp.com /script=winscptestscript\winscpscript500m>winscptestscript\winscpstart500.bat
echo exit>>winscptestscript\winscpstart500.bat
echo start /B winscp.com /script=winscptestscript\winscpscript100m>winscptestscript\winscpstart100.bat
echo exit>>winscptestscript\winscpstart100.bat
echo TEST_START_TIME %date% %time%>>downthroughputresult.txt
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
    echo Combine_Throughput_Test Run%%A starting, Please wait...
    echo Run%%A test starting>>uploadthroughputresult.txt
    echo Run%%A test starting>>downthroughputresult.txt
    echo ======================>>uploadthroughputresult.txt
    echo ======================>>downthroughputresult.txt
    if %w% == 2 (
        ren winscptestscript\1Gtest1* 1Gtest1!timestamp!
        ren winscptestscript\1Gtest2* 1Gtest2!timestamp!
        start /B winscptestscript\winscpstartup1.bat
        start /B winscptestscript\winscpstartup2.bat
        start /B winscptestscript\winscpstart200.bat
        start /B winscptestscript\winscpstart500.bat
        timeout /t 30 /nobreak >nul)
    if %w% == 3 (
        ren winscptestscript\1Gtest1* 1Gtest1!timestamp!
        ren winscptestscript\1Gtest2* 1Gtest2!timestamp!
        ren winscptestscript\1Gtest3* 1Gtest3!timestamp!
        start /B winscptestscript\winscpstartup1.bat
        start /B winscptestscript\winscpstartup2.bat
        start /B winscptestscript\winscpstartup3.bat
        start /B winscptestscript\winscpstart200.bat
        start /B winscptestscript\winscpstart100.bat
        start /B winscptestscript\winscpstart500.bat
        timeout /t 30 /nobreak >nul)
    if %w% == 1 (
        ren winscptestscript\1Gtest1* 1Gtest1!timestamp!
        start /B winscptestscript\winscpstartup1.bat
        start /B winscptestscript\winscpstart500.bat
        timeout /t 30 /nobreak >nul)
    echo Run%%A test end>>uploadthroughputresult.txt
    echo ======================>>uploadthroughputresult.txt
    echo Run%%A test end>>downthroughputresult.txt
    echo ======================>>downthroughputresult.txt
    taskkill /f /im  WinSCP.exe
    taskkill /f /im  WinSCP.com
    del 1GB.zip
    del 200MB.zip
    del 500MB.zip)
echo TEST_END_TIME %date% %time%>>uploadthroughputresult.txt
echo TEST_END_TIME %date% %time%>>downthroughputresult.txt
rmdir /s /q winscptestscript
del WinSCP.com
del WinSCP.exe
echo =============================================================
echo =============================================================
echo Test Finish...
echo Please check the uploadthroughputresult/downthroughputresult.txt to the result 
echo Press any key to exit.
pause >nul
exit