@echo off
set /a p=400
set /a e=1048576
set /a a=%p%*%e% 
fsutil file createnew test%p%MB %a%
echo ftp> ftp.txt
echo ftp>> ftp.txt
echo get test_400m.zip>> ftp.txt
ftp -s:ftp.txt  ftp.speed.hinet.net
bye
echo test finish,press any key to exit.
pause
exit