::v1.0
@ECHO OFF
ECHO -------------------------------------------------------------------------------------
ECHO  You are about to download some software which allows to download content from
ECHO  video-sharing services.
ECHO.
ECHO  I do not own rights for any of following binaries:
ECHO  - youtube-dl.exe (https://youtube-dl.org/)
ECHO  - vcredist_x86.exe (https://www.microsoft.com/en-US/download/details.aspx?id=5555)
ECHO  - phantomjs.exe (https://phantomjs.org/)
ECHO  - ffmpeg.exe (https://www.ffmpeg.org/)
ECHO.
ECHO  If you wish to continue, it means that you agree to terms attached to
ECHO  above mentioned software and terms of video-sharing services you will download from.
ECHO.
ECHO  My work considers only batch scripts that make use of those binaries.
ECHO  I made it just for fun. Hope it will save you some time.
ECHO -------------------------------------------------------------------------------------
ECHO.
ECHO  Hit any key to start download...
PAUSE >NUL
SET ytd_link=https://github.com/MariuszSielicki/YTD/raw/master/main/ytd.bat
SET ytd_file=ytd.bat

SET youtube_dl_link=https://yt-dl.org/latest/youtube-dl.exe
SET youtube_dl_file=youtube-dl.exe

SET vcredist_link=https://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe
SET vcredist_file=vcredist_x86.exe

SET phantomjs_link=https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-windows.zip
SET phantomjs_file=phantomjs-2.1.1-windows.zip

SET ffmpeg_link=https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20200312-675bb1f-win64-static.zip
SET ffmpeg_file=ffmpeg-20200312-675bb1f-win64-static.zip

MD ytd\tmp

CLS & ECHO [           ] Downloading...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%ytd_link%',        '.\ytd\%ytd_file%')"
CLS & ECHO [-^>        ] Downloading...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%youtube_dl_link%', '.\ytd\%youtube_dl_file%')"
CLS & ECHO [--^>       ] Downloading...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%vcredist_link%',   '.\ytd\tmp\%vcredist_file%')"
CLS & ECHO [---^>      ] Downloading...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%phantomjs_link%',  '.\ytd\tmp\%phantomjs_file%')"
CLS & ECHO [----^>     ] Downloading...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%ffmpeg_link%',     '.\ytd\tmp\%ffmpeg_file%')"

CLS & ECHO [-----^>    ] Unzipping...
powershell -Command "(Expand-Archive .\ytd\tmp\%phantomjs_file% .\ytd\tmp\)"
powershell -Command "(Expand-Archive .\ytd\tmp\%ffmpeg_file% .\ytd\tmp\)"

CLS & ECHO [-------^>  ] Copying...
MOVE /Y .\ytd\tmp\%ffmpeg_file:.zip=%\bin\ffmpeg.exe .\ytd\
MOVE /Y .\ytd\tmp\%phantomjs_file:.zip=%\bin\phantomjs.exe .\ytd\

CLS & ECHO [--------^> ] Installing Microsoft Visual C++ 2010 Redistributable Package (x86)...
.\ytd\tmp\%vcredist_file% /q

CLS & ECHO [---------^>] Cleaning up...
RD /S/Q .\ytd\tmp

CLS & ECHO [---------^>] Done.
ECHO.
ECHO Go to ytd folder and run ytd.bat
PAUSE >NUL