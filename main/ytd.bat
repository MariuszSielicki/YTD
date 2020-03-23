::v 1.1
@ECHO OFF
SET video="--no-overwrites --no-continue --console-title --no-warnings"
SET audio="--no-overwrites --no-continue --console-title --no-warnings -x --audio-format mp3 --audio-quality 0"
SET custom="-F"
SET command=%video%

::for /f "tokens=4 delims= " %%a in ('VER') do SET winver=%%a
::for /f "tokens=1 delims=." %%a in ('ECHO %winver%') do SET winver=%%a

:start
CLS
ECHO Options
ECHO -------
ECHO.
ECHO  (L)ink   %url%
REM ECHO  (F)ormat %command%
IF %command%==%video% ECHO  (F)ormat (x)VIDEO ( )AUDIO ( )CUSTOM
IF %command%==%audio% ECHO  (F)ormat ( )VIDEO (x)AUDIO ( )CUSTOM
IF %command%=="%custom%" ECHO  (F)ormat ( )VIDEO ( )AUDIO (x)CUSTOM: %command%
ECHO  (C)ustomize
ECHO  (V)erify
ECHO  (E)xecute
ECHO  (U)pdate youtube-dl
ECHO.
ECHO  (Q)uit
ECHO.
CHOICE /C LFCVEUQ
IF ERRORLEVEL 7 GOTO quit
IF ERRORLEVEL 6 GOTO update
IF ERRORLEVEL 5 GOTO execute
IF ERRORLEVEL 4 GOTO verify
IF ERRORLEVEL 3 GOTO customize
IF ERRORLEVEL 2 GOTO format
IF ERRORLEVEL 1 GOTO link

:link
	CLS
	ECHO Options ^> Link
	ECHO --------------
	ECHO.
	SET /P url="Enter URL here: "
	::escaping &
	SET "url=%url:&=^&%"
	GOTO start

:format
	CLS
	ECHO Options ^> Format
	ECHO ----------------
	ECHO.
	ECHO  (V)ideo
	ECHO  (A)udio
	ECHO.
	ECHO  Go (b)ack
	ECHO.
	CHOICE /C AVB
	IF ERRORLEVEL 3 GOTO start
	IF ERRORLEVEL 2 SET command=%video%
	IF ERRORLEVEL 1 SET command=%audio%
	GOTO start

:customize
	CLS
	ECHO Options ^> Customize
	ECHO -------------------
	ECHO.
	ECHO  (C)ustom parameters
	ECHO  (H)elp
	ECHO.
	ECHO  Go (b)ack
	ECHO.
	CHOICE /C CHB
	IF ERRORLEVEL 3 GOTO start
	IF ERRORLEVEL 2 GOTO help
	IF ERRORLEVEL 1 GOTO custom
	:custom
		CLS
		ECHO Options ^> Customize ^> Custom parameters
		ECHO ---------------------------------------
		ECHO.
		SET /P custom=Enter custom parameters:
		SET command="%custom%"
		GOTO start
	:help
		CLS
		ECHO Options ^> Customize ^> Help
		ECHO --------------------------
		ECHO.
		ECHO Viewing youtube-dl_help.txt.
		ECHO.
		ECHO Close notepad to continue...
		IF EXIST youtube-dl_help.txt notepad youtube-dl_help.txt 
		IF NOT EXIST youtube-dl_help.txt youtube-dl -help >youtube-dl_help.txt & notepad youtube-dl_help.txt
		GOTO customize

:verify
	CLS
	ECHO Options ^> Verify
	ECHO ----------------
	ECHO.
	::escaping "=" in FOR loop
	SET url_backup=%url%
	SET "url=%url:?v=?v^%"
	FOR /F "tokens=* usebackq" %%f IN (`youtube-dl --get-title %url%`) DO ECHO  Title:   %%f
	
	IF %command%==%video% ECHO  Format: (x)VIDEO ( )AUDIO ( )CUSTOM
	IF %command%==%audio% ECHO  Format:  ( )VIDEO (x)AUDIO ( )CUSTOM
	IF %command%=="%custom%" ECHO  Format:  ( )VIDEO ( )AUDIO (x)CUSTOM	
	
	SET command_backup=%command%
	SET command=%command:"=%
	ECHO  Command: youtube-dl %command% %url%
	
	SET command=%command_backup%
	SET url=%url_backup%

	ECHO.
	ECHO Hit any key to back to options.
	PAUSE >NUL
	GOTO start

:execute
	CLS
	ECHO Options ^> Execute
	ECHO -----------------
	ECHO.	
	::escaping "
	SET command_backup=%command%
	SET command=%command:"=%
	youtube-dl.exe %command% %url%
	
	SET command=%command_backup%
	
	ECHO.
	ECHO Done. Hit any key to back to options.
	PAUSE >NUL
	GOTO start

:update
	CLS
	ECHO Options ^> Update youtube-dl
	ECHO ---------------------------
	ECHO.
	@youtube-dl.exe -U
	ECHO.
	ECHO Done. Hit any key to back to options.
	PAUSE >NUL
	GOTO start

:quit
	EXIT