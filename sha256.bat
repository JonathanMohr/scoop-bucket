@echo off

:: Usage: .\get_sha256.bat <url>

set "URL=%~1"

if "%URL%"=="" (
    echo Usage: %~nx0 ^<url^>
    exit /b 1
)

set "CODE="
for /f %%c in ('curl -fsSL -o NUL -w "%%{http_code}" "%URL%"') do set "CODE=%%c"

if not "%CODE%"=="200" (
    >&2 echo Error: Could not find file at: %URL%
    exit /b 1
)

set "TMPFILE=%TEMP%\download_%RANDOM%.tmp"

curl -fsSL -o "%TMPFILE%" "%URL%" || (
    >&2 echo Error: Download failed: %URL%
    exit /b 1
)

set "HASH="
for /f "skip=1 delims=" %%h in ('certutil -hashfile "%TMPFILE%" SHA256') do (
    if not defined HASH set "HASH=%%h"
)
set "HASH=%HASH: =%"

del "%TMPFILE%"

if not defined HASH (
    >&2 echo Error: Failed to compute SHA256 hash.
    exit /b 1
)

echo SHA256: %HASH%
