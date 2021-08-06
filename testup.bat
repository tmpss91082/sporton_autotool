@echo off
echo %RANDOM%%RANDOM%>123
set /p a=<123
echo %a%
ren 1111.txt %a%.txt
pause
exit