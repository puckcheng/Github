@ECHO OFF & CD/D "%~dp1"
:ReMux1
IF "%~1"=="" GOTO :STOP
IF /I "%~x1"==".webm" (Set Ext=.mp4) ELSE (GOTO :STOP) 
::Set Ext=.mp4
"C:\Program Files (x86)\MeGUI-2715-32\tools\ffmpeg\ffmpeg.exe"  -i "%~dpn1.webm" -vcodec copy -acodec copy "%~dpn1%Ext%"
::IF %ERRORLEVEL% == 0 (Del "%~1")
SHIFT /1
GOTO :ReMux1
:STOP
pause

