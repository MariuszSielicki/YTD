SET ytd_link=https://github.com/MariuszSielicki/YTD/raw/master/ytd.bat
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

powershell -Command "(New-Object Net.WebClient).DownloadFile('%ytd_link%',        '.\ytd\%ytd_file%')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('%youtube_dl_link%', '.\ytd\%youtube_dl_file%')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('%vcredist_link%',   '.\ytd\tmp\%vcredist_file%')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('%phantomjs_link%',  '.\ytd\tmp\%phantomjs_file%')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('%ffmpeg_link%',     '.\ytd\tmp\%ffmpeg_file%')"

powershell -Command "(Expand-Archive .\ytd\tmp\%phantomjs_file% .\ytd\tmp\)"
MOVE /Y .\ytd\tmp\%phantomjs_file:.zip=%\bin\phantomjs.exe .\ytd\

powershell -Command "(Expand-Archive .\ytd\tmp\%ffmpeg_file% .\ytd\tmp\)"
MOVE /Y .\ytd\tmp\%ffmpeg_file:.zip=%\bin\ffmpeg.exe .\ytd\

.\ytd\tmp\%vcredist_file% /q
RD /S/Q .\ytd\tmp