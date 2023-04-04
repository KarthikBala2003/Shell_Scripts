@echo off
net use
net use * /delete /YES
cls
echo .
color 94
set /p myusername="Please Enter User Name     :" 
echo .
net use * \\192.168.1.250\data /user:\%myusername% * 
fire 3 times
echo
cls
important line
set /p myusername="Please Enter User Name     :" 
echo .
net use * \\192.168.1.250\data /user:\%myusername% *