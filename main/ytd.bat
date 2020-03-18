::v 1.0
@ECHO OFF
SET video=""
SET audio="-x --audio-format mp3 --audio-quality 0"
SET format=%video%

:start
CLS
ECHO 1. URL         %url%
ECHO 2. AUDIO/VIDEO %format%
ECHO 3. CHECK
ECHO 4. EXECUTE
ECHO 5. UPDATE
ECHO 6. EXIT

ECHO Select one option
CHOICE /C 123456

IF ERRORLEVEL 6 GOTO :opt_6
IF ERRORLEVEL 5 GOTO :opt_5
IF ERRORLEVEL 4 GOTO :opt_4
IF ERRORLEVEL 3 GOTO :opt_3
IF ERRORLEVEL 2 GOTO :opt_2
IF ERRORLEVEL 1 GOTO :opt_1

:opt_1
	ECHO.
	SET /p url="Enter URL here: "
	::escaping &
	SET "url=%url:&=^&%"
	GOTO :start

:opt_2
	ECHO.
	ECHO Select V for VIDEO
	ECHO Select A for AUDIO
	CHOICE /C AV
	IF ERRORLEVEL 2 GOTO :VIDEO
	IF ERRORLEVEL 1 GOTO :AUDIO
	:VIDEO
		SET format=%video%
		GOTO :start
	:AUDIO
		SET format=%audio%
		GOTO :start

:opt_3
	ECHO.
	ECHO  URL:    %url%
	IF %format%==%video% ECHO  Format: (x)VIDEO ( )AUDIO
	IF %format%==%audio% ECHO  Format: ( )VIDEO (x)AUDIO
	ECHO.
	ECHO Hit any key to back to options.
	PAUSE >NUL
	GOTO :start

:opt_4
	ECHO.
	IF %format%==%video% GOTO :video
	IF %format%==%audio% GOTO :audio
	:video
		::escaping "
		SET format=%format:"=%
		@youtube-dl.exe --no-overwrites --no-continue --restrict-filenames  %format% %url%
		SET format=%video%
		ECHO.
		ECHO Done. Hit any key to back to options.
		PAUSE >NUL
		GOTO :start
	:audio
		::escaping "
		SET format=%format:"=%
		@youtube-dl.exe --no-overwrites --no-continue --restrict-filenames  %format% %url%
		SET format=%audio%
		ECHO.
		ECHO Done. Hit any key to back to options.
		PAUSE >NUL
		GOTO :start

:opt_5
	ECHO.
	@youtube-dl.exe -U
	ECHO.
	ECHO Done. Hit any key to back to options.
	PAUSE >NUL
	GOTO :start

:opt_6
	EXIT