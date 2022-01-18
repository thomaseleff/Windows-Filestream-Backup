@ECHO OFF

:: This Batch File Backs-up Filestreams defined in \config.json
TITLE Filestream Backup

:: Set Variables
SETLOCAL ENABLEDELAYEDEXPANSION
SET DIR=%~dp0%
SET CONFIGFILE=config.txt
SET CONFIGPATH=%DIR%%CONFIGFILE%
SET "SEP="
SET CHAR=-
SET "PADDING="
SET "SPACE= "

:: Output Header
FOR /L %%I IN (1,1,78) DO (
    SET SEP=!SEP!!CHAR!
)
FOR /L %%I IN (1,1,29) DO (
    SET PADDING=!PADDING!!SPACE!
)
ECHO +!SEP!+
ECHO !PADDING!Filestream Backup !PADDING!
ECHO +!SEP!+
ECHO.
ECHO    DATETIME: %date% %time%
ECHO.
ECHO.

:: Check if \logs Directory Exists
IF NOT EXIST "!DIR!logs\" (
    MD "!DIR!logs"
) 

:: Copy Filestream
FOR /F "delims=, skip=1 tokens=1,2,3,4 usebackq" %%W IN ("%CONFIGPATH%") DO (

    :: Set Variables
    SET NAME=%%W
    SET NAME=!NAME:"=!
    SET SRC=%%X
    SET SRC=!SRC:"=!
    SET SRCLAST=!SRC:~-1!
    SET DST=%%Y
    SET DST=!DST:"=!
    SET DSTLAST=!DST:~-1!
    SET OPTION=%%Z
    SET OPTION=!OPTION:"=!
    SET "SEP="
    CALL :STRLEN NAME NUM
    SET /A NUM=NUM+9

    :: Correct SRC and DST Quotations
    IF "!SRCLAST!"=="\" (
        SET SRC="!SRC! "
    ) ELSE (
        IF "!SRCLAST!"=="/" ( 
            SET SRC="!SRC! "
        ) ELSE (
            IF NOT "!SRC!"=="!SRC: =!" (
                SET SRC="!SRC!"
            )
        )
    )
    IF "!DSTLAST!"=="\" (
        SET DST="!DST! "
    ) ELSE (
        IF "!DSTLAST!"=="/" ( 
            SET DST="!DST! "
        ) ELSE (
            IF NOT "!DST!"=="!DST: =!" (
                SET DST="!DST!"
            )
        )
    )

    :: Backup Filestream
    FOR /L %%I IN (1,1,!NUM!) DO (
        SET SEP=!SEP!!CHAR!
    )
    ECHO Backing up !NAME!
    ECHO +!SEP!+
    ECHO.
    ECHO     SRC    : !SRC!
    ECHO     DST    : !DST!
    ECHO     OPTION : !OPTION!
    ECHO     LOG    : ~\logs\!NAME! Backup.log
    ECHO.
    ROBOCOPY !SRC! !DST! * !OPTION! /LOG:"!DIR!logs\!NAME! Backup.log"
    ECHO.
    ECHO       NOTE: !NAME! backed up successfully.
    ECHO.
)

GOTO:EOF
:: STRLEN Function Courtesy of https://ss64.com/nt/syntax-strlen.html
::     STRVAR: Name of the variable containing the string to count.
::     RTNVAR: Name of the variable to contain the length of STRVAR.
:STRLEN  STRVAR  [RTNVAR]
    SETLOCAL ENABLEDELAYEDEXPANSION
    SET "s=#!%~1!"
    SET "LEN=0"
    FOR %%N IN (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) DO (
            IF "!s:~%%N,1!" NEQ "" (
            SET /a "LEN+=%%N"
            SET "s=!s:~%%N!"
        )
    )
    ENDLOCAL & IF "%~2" NEQ "" (SET %~2=%LEN%) ELSE ECHO %LEN%
