::v 1.0
@ECHO OFF
SET video="--no-overwrites --no-continue --restrict-filenames"
SET audio="--no-overwrites --no-continue --restrict-filenames -x --audio-format mp3 --audio-quality 0"
SET format=%video%

::for /f "tokens=4 delims= " %%a in ('VER') do SET winver=%%a
::for /f "tokens=1 delims=." %%a in ('ECHO %winver%') do SET winver=%%a

:start
CLS
ECHO 1. URL    %url%
ECHO 2. FORMAT %format%
ECHO 3. CUSTOMIZE
ECHO 4. CHECK
ECHO 5. EXECUTE
ECHO 6. UPDATE
ECHO 7. EXIT

ECHO Select one option
CHOICE /C 1234567
GOTO opt_%ERRORLEVEL%

:opt_1
	ECHO.
	SET /p url="Enter URL here: "
	::escaping &
	SET "url=%url:&=^&%"
	GOTO start

:opt_2
	ECHO.
	ECHO Select V for VIDEO
	ECHO Select A for AUDIO
	ECHO Select B to go back
	CHOICE /C AVB
	IF ERRORLEVEL 3 GOTO start
	IF ERRORLEVEL 2 GOTO video
	IF ERRORLEVEL 1 GOTO audio
	:video
		SET format=%video%
		GOTO start
	:audio
		SET format=%audio%
		GOTO start

:opt_3
	ECHO.
	ECHO Select C for custom parameters
	ECHO Select H for help
	ECHO Select B to go back
	CHOICE /C CHB
	IF ERRORLEVEL 3 GOTO start
	IF ERRORLEVEL 2 GOTO help
	IF ERRORLEVEL 1 GOTO custom
	:custom
		SET /P custom=Enter custom parameters:
		SET format=%custom%
		GOTO start
	:help
		ECHO Viewing youtube-dl_help.txt
		IF EXIST youtube-dl_help.txt notepad youtube-dl_help.txt 
		IF NOT EXIST youtube-dl_help.txt ECHO Take a look and close this file to contunue. >youtube-dl_help.txt & ECHO. >>youtube-dl_help.txt & youtube-dl -help >>youtube-dl_help.txt & notepad youtube-dl_help.txt
		CLS
		GOTO opt_3

:opt_4
	ECHO.
	ECHO  URL:    %url%
	IF %format%==%video% ECHO  Format: (x)VIDEO ( )AUDIO ( )CUSTOM
	IF %format%==%audio% ECHO  Format: ( )VIDEO (x)AUDIO ( )CUSTOM
	IF %format%==%custom% ECHO  Format: ( )VIDEO ( )AUDIO (x)CUSTOM: %custom%
	ECHO.
	ECHO Hit any key to back to options.
	PAUSE >NUL
	GOTO start

:opt_5
	ECHO.
	IF %format%==%video% GOTO video
	IF %format%==%audio% GOTO audio
	IF %format%==%custom% GOTO custom
	:video
		::escaping "
		SET format=%format:"=%
		youtube-dl.exe %format% %url%
		SET format=%video%
		GOTO finish
	:audio
		::escaping "
		SET format=%format:"=%
		@youtube-dl.exe %format% %url%
		SET format=%audio%
		GOTO finish
	:custom
		::escaping "
		SET format=%format:"=%
		@youtube-dl.exe %format% %url%
		SET format=%custom%
		GOTO finish
	:finish	
		ECHO.
		ECHO Done. Hit any key to back to options.
		PAUSE >NUL
		GOTO start

:opt_6
	ECHO.
	@youtube-dl.exe -U
	ECHO.
	ECHO Done. Hit any key to back to options.
	PAUSE >NUL
	GOTO start

:opt_7
	EXIT