@ECHO OFF & CD /D "%~dp1"

rem static start
rem Required programs
set vspipe="C:\Program Files (x86)\VapourSynth\core64\vspipe.exe"
set mediainfo="C:\Program Files (x86)\MediainfoCLI\MediaInfo.exe"
set x265="C:\Program Files (x86)\MeGUI-2715-32\tools\x265\x64\x265.exe"
set ffmpeg="C:\Program Files (x86)\MeGUI-2715-32\tools\ffmpeg\ffmpeg.exe"
rem static end

SETLOCAL ENABLEDELAYEDEXPANSION
SETLOCAL
dir /b > list.tmp
type list.tmp | findstr /e .MP4 >> list.txt
del list.tmp

FOR /F %%g in (list.txt) DO (
set name=%%g

%mediainfo% "--Inform=Video;%%FrameCount%%" "%~dp1!name!" > "D:\Media\TEMP\frames.txt"

echo import vapoursynth as vs > "!name!.vpy"
echo import sys >> "!name!.vpy"
echo core=vs.get_core(accept_lowercase=True,threads=4^) >> "!name!.vpy"
echo core.max_cache_size=8000 >> "!name!.vpy"
echo source=r'%~dp1!name!' >> "!name!.vpy"
echo src=core.lsmas.LWLibavSource(source,threads=1^) >> "!name!.vpy"
echo src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0^) >> "!name!.vpy"
echo src.set_output(^) >> "!name!.vpy"

call :DoEncode !name!
)
ENDLOCAL

Echo  
::ping 127.0.0.1 -n 1 >nul
::mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)
Echo done!
goto :EOF

:DoEncode

Echo Building File Index......

FOR /F %%i in (D:\Media\TEMP\frames.txt) DO set tframes=%%i

%vspipe% --y4m "%~1.vpy" - | %x265% ^
--y4m --preset slow --frame-threads 8 ^
--frames %tframes% --output-depth 10 --crf 18 ^
--qcomp 0.65 --merange 44 --aq-strength 0.8 ^
--output "D:\Media\TEMP\%~1_tmp.mp4" -

::ping 127.0.0.1 -n 3 >nul

%ffmpeg% -fflags +genpts -i "D:\Media\TEMP\%~1_tmp.mp4" -i "%~1" -map 0:v -map 1:a -vcodec copy  -acodec copy "%~1_arc.mp4"

::ping 127.0.0.1 -n 1 >nul

del "%~1.vpy"
del "%~1.lwi"
del "D:\Media\TEMP\frames.txt"
del "D:\Media\TEMP\%~1_tmp.mp4"
cls

EXIT /B

:EOF



