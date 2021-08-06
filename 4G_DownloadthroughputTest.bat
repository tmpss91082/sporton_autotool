@echo off
echo Test Start>downthroughputresult.txt
set /p p="How manny run do you want to test: "
set /p W="How manny threat do you want start simultaneously(max is 3): "
mkdir winscptestscript
echo open ftp://anonymous:anonymous@90.130.70.73/>winscptestscript\winscpscript500m.txt
echo cd />>winscptestscript\winscpscript500m.txt
echo get 500MB.zip>>winscptestscript\winscpscript500m.txt
echo exit>>winscptestscript\winscpscript500m.txt
echo open ftp://anonymous:anonymous@90.130.70.73/>winscptestscript\winscpscript200m.txt
echo cd />>winscptestscript\winscpscript200m.txt
echo get 200MB.zip>>winscptestscript\winscpscript200m.txt
echo exit>>winscptestscript\winscpscript200m.txt
echo open ftp://anonymous:anonymous@90.130.70.73/>winscptestscript\winscpscript100m.txt
echo cd />>winscptestscript\winscpscript100m.txt
echo get 1GB.zip>>winscptestscript\winscpscript100m.txt
echo exit>>winscptestscript\winscpscript100m.txt
echo start /B winscp.com /script=winscptestscript\winscpscript200m.txt>winscptestscript\winscpstart200.bat
echo exit>>winscptestscript\winscpstart200.bat
echo start /B winscp.com /script=winscptestscript\winscpscript500m.txt>winscptestscript\winscpstart500.bat
echo exit>>winscptestscript\winscpstart500.bat
echo start /B winscp.com /script=winscptestscript\winscpscript100m.txt>winscptestscript\winscpstart100.bat
echo exit>>winscptestscript\winscpstart100.bat
echo TEST_START_TIME %date% %time%>>downthroughputresult.txt
for /L %%A IN (1 ,1 , %p%) do (
    echo =============================================================
    echo Downloadthroughput test Run%%A starting, Please wait...
    echo run%%A test starting>>downthroughputresult.txt
    echo ======================>>downthroughputresult.txt
    if %w% == 2 (
        start /B winscptestscript\winscpstart200.bat
        start /B winscptestscript\winscpstart500.bat
        timeout /t 30 /nobreak >nul)
    if %w% == 3 (
        start /B winscptestscript\winscpstart200.bat
        start /B winscptestscript\winscpstart100.bat
        start /B winscptestscript\winscpstart500.bat
        timeout /t 30 /nobreak >nul)
    if %w% == 1 (
        start /B winscptestscript\winscpstart500.bat
        timeout /t 30 /nobreak >nul)
    echo Run%%A test end>>downthroughputresult.txt
    echo ======================>>downthroughputresult.txt
    taskkill /f /im  WinSCP.exe
    taskkill /f /im  WinSCP.com
    del 1GB.zip
    del 200MB.zip
    del 500MB.zip)
echo TEST_END_TIME %date% %time%>>downthroughputresult.txt
rmdir /s /q winscptestscript
del WinSCP.com
del WinSCP.exe
echo =============================================================
echo =============================================================
echo Test Finish...
echo Please check the downthroughputresult.txt to the result 
echo Press any key to exit.
pause >nul
exit


