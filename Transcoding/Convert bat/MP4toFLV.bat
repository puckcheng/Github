@ECHO OFF & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI-2715-32\tools\ffmpeg\ffmpeg.exe"  -i "%~dpn1%~x1" -vcodec copy -acodec copy "%~dpn1.flv"

pause

