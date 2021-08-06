@echo off
echo ftp> ftp.txt
echo ftp>> ftp.txt
echo get test_400m.zip>> ftp.txt
ftp -s:ftp.txt  ftp.speed.hinet.net
bye
echo test finish,press any key to exit.
pause
exit