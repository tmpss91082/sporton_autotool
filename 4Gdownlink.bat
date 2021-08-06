@echo off
echo test start...>downthroughputresult.txt
set /p p="How manny run do you want to test : "
set /p W="How manny threat do you want start simultaneously : "
echo ftp>ftp.txt
echo ftp>>ftp.txt
echo get test_200m.zip>> ftp.txt
echo bye>>ftp.txt
for /L %%B IN (1 ,1 , %w%) do (
    echo @echo off>4Gthourghputdownloadtest%%B.bat
    echo ftp -s:ftp.txt -x:300000000 -r:300000000 -w:65535000 ftp.speed.hinet.net>>downthroughputresult.txt>>4Gthourghputdownloadtest%%B.bat
    echo exit>>4Gthourghputdownloadtest%%B.bat)
for /L %%A IN (1 ,1 , %p%) do (
    echo downloadthroughput test run%%A starting, please wait...
    echo run%%A test starting>>downthroughputresult.txt
    echo ======================>>downthroughputresult.txt
    for /L %%C IN (2 ,1 , %w%) do (
        start 4Gthourghputdownloadtest%%C.bat)
    start /wait 4Gthourghputdownloadtest1.bat ^>^>downthroughputresult.txt
    echo run%%A test end>>downthroughputresult.txt
    echo ======================>>downthroughputresult.txt
    del test_020m.zip)
for /L %%D IN (1 ,1 , %w%) do (
    del 4Gthourghputdownloadtest%%D.bat)
pause
del ftp.txt
echo test finish...
echo please check the downthroughputresult.txt to the result 
echo press any key to exit.
pause
exit