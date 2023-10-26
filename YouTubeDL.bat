@echo off

REM #########################################################################################
REM
REM    ______                          ____  _________ __            __
REM   / ____/___ _________  __________/ __ \/ __/ ___// /____  ___  / /
REM  / /   / __ `/ ___/ _ \/ ___/ ___/ / / / /_ \__ \/ __/ _ \/ _ \/ / 
REM / /___/ /_/ / /  /  __(__  |__  ) /_/ / __/___/ / /_/  __/  __/ /  
REM \____/\__,_/_/   \___/____/____/\____/_/  /____/\__/\___/\___/_/   
REM
REM
REM #########################################################################################
REM
REM YouTube-DLP Front-End
REM 
REM // SET BAT/EXE PATHS
SET GITPATH=D:\Work\Github\caressofsteel\youtube-dl-frontend
SET YTDLPATH=C:\Apps\Portable\MyApps\YouTubeDL
REM 
REM # YouTubeDL.bat
REM - Edit Batch from %GITPATH%
REM - Copy updates to portable apps, Run from portable apps
REM 
REM # YT-DLP.exe
REM - Updates and Runs from %YTDLPATH%
REM
REM # NOTE
REM If a file or path contains a '!' character, you must set SETLOCAL DISABLEDELAYEDEXPANSION prior
REM to calling yt-dlp.exe. Otherwise, it will fail with:
REM `yt-dlp.exe: error: Cannot download a video and extract audio into the same file!`
REM
REM #########################################################################################

:: // ENV
SETLOCAL EnableDelayedExpansion
SET LF=^

:: // Get Last Update Timestamp(s)
for %%a in (%YTDLPATH%\yt-dlp.exe) do set YTDLDATE=%%~ta
for %%a in (YouTubeDL.bat) do set BATCHDATE=%%~ta

:: // Assign Timestamp :: Date+Time :~0,88% | Date :~0,10%
set "YTDLDATE=%YTDLDATE:~0,10%"
set "BATCHDATE=%BATCHDATE:~0,10%"

:: // Config Console Window
:: 1(Blue), 2(Green), 3(Cyan), 4(Red), 5(Purple), 6(Yellow), 7(LGray), 8(Gray)
COLOR 6F
MODE con:cols=89 lines=45
SET TITLE=".: YouTube-DLP Front-End v%BATCHDATE% | EXE v%YTDLDATE% :."

::pause

cls
goto menu

:menu
cls
echo.
SETLOCAL EnableDelayedExpansion
echo !TITLE:^"=!
echo.        
echo ### CHOOSE FORMAT ######################################################################
echo.         
	echo [ 1 ] - Audio (MP3)
	echo [ 2 ] - Video (MP4)
	echo [ 3 ] - Video (MP4) HQ/BEST
	echo [ 4 ] - Video (Choose Format)
	echo [ 5 ] - Channel (MP4)
	echo [ 6 ] - Playlist (MP3, 160K)
	echo [ 7 ] - Playlist (MP4)
	echo [ 8 ] - Time Span (MP4)
	echo [ 9 ] - Video Proxy (Socks5, MP4)
	echo [ 0 ] - Update YT-DLP (YouTubeDLP/Batch)
	echo.
echo ########################################################################################
echo.
set url=
set /P menu=Choose: 
if "%menu%"=="1" (goto download_audio)
if "%menu%"=="2" (goto download_video)
if "%menu%"=="3" (goto download_video_best)
if "%menu%"=="4" (goto download_video_format)
if "%menu%"=="5" (goto download_channel)
if "%menu%"=="6" (goto download_playlist)
if "%menu%"=="7" (goto download_playlist_video)
if "%menu%"=="8" (goto download_timespan)
if "%menu%"=="9" (goto download_video_best_proxy)
if "%menu%"=="0" (goto update)
if "%menu%"=="" (goto menu)


REM ########################################################################################
REM [- 0 -]
REM ########################################################################################

:update
cls
ECHO [ YouTube-DLP (EXE UPDATE) ]
echo.

:: Update Executable
echo Updating YT-DLP.exe in %YTDLPATH%
echo.
REM %YTDLPATH%\yt-dlp.exe -U
%YTDLPATH%\yt-dlp.exe --update-to nightly

:: Update Batch
echo.
echo Copying YouTubeDL.bat from %GITPATH% 
echo to %YTDLPATH%
copy /y %GITPATH%\YouTubeDL.bat %YTDLPATH%
echo.

pause
goto menu


REM ########################################################################################
REM [- 1 -]
REM ########################################################################################

:download_audio
cls
ECHO [ YouTube-DLP Audio (MP3) ]
echo.

SETLOCAL DISABLEDELAYEDEXPANSION
set /P url="Enter Audio URL: "
yt-dlp.exe --rm-cache-dir -ciw -x --audio-format mp3 --embed-thumbnail -o "D:\Downloads\%%(title)s.%%(ext)s" %url%

pause
goto menu


REM ########################################################################################
REM [- 2 -]
REM ########################################################################################

:download_video
cls
ECHO [ YouTube-DLP Video (MP4) ]
echo.

SETLOCAL DISABLEDELAYEDEXPANSION
set /P url="Enter Video URL: "
yt-dlp.exe --rm-cache-dir -ciw -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" -o "D:\Downloads\%%(title)s.%%(ext)s" %url%

pause
goto menu


REM ########################################################################################
REM [- 3 -]
REM ########################################################################################

:download_video_best
cls
ECHO [ YouTube-DLP Video (MP4 HQ/BEST) ]
echo.

SETLOCAL DISABLEDELAYEDEXPANSION
set /P url="Enter Video URL: "
yt-dlp.exe --verbose --rm-cache-dir -ciw --format "bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4 -o "D:\Downloads\%%(title)s.%%(ext)s" %url%

pause
goto menu


REM ########################################################################################
REM [- 4 -]
REM ########################################################################################

:download_video_format
cls
ECHO [ YouTube-DLP Video (Choose Format) ]
echo.

SETLOCAL DISABLEDELAYEDEXPANSION
set /P url="Enter Video URL: "
yt-dlp.exe -F %url%
pause
set /p vformat="Enter Video Code: "
set /p aformat="Enter Audio Code: "
yt-dlp.exe --rm-cache-dir -ciw -f "%vformat%+%aformat%" --download-archive D:\Downloads\downloaded.txt --merge-output-format mp4 -o "D:\Downloads\%%(title)s.%%(ext)s" %url%

pause
goto menu


REM ########################################################################################
REM [- 5 -]
REM ########################################################################################

:download_channel
cls
ECHO [ YouTube-DLP Channel (MP4 Video) ]
echo.

SETLOCAL DISABLEDELAYEDEXPANSION
set /P url="Enter Channel URL: "
yt-dlp.exe --rm-cache-dir -ciw -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" -o "D:\Temp\YouTubeDL\%%(title)s.%%(ext)s" --download-archive "D:\Temp\YouTubeDL\downloaded.txt" -v %url%

pause
goto menu


REM ########################################################################################
REM [- 6 -]
REM ########################################################################################

:download_playlist
cls
ECHO [ YouTube-DLP Playlist (MP3 160K) ]
echo.

:: todo
:: ask range (1-###)
:: ask format (mp3, m4a, opus)

SETLOCAL DISABLEDELAYEDEXPANSION
set /P url="Enter Audio Playlist ID or URL: "

yt-dlp.exe --rm-cache-dir -ciw -o "D:\Downloads\%%(playlist_index)s - %%(title)s.%%(ext)s" -x --audio-format mp3 --embed-thumbnail --yes-playlist "%url%"

::yt-dlp --rm-cache-dir --ignore-errors -ciw --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "Z:\Music\!NewMusic\%%(playlist_index)s - %%(title)s.%%(ext)s" --yes-playlist "%url%"

::yt-dlp --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "Z:\Music\!NewMusic\%%(playlist_index)s - %%(title)s.%%(ext)s" --yes-playlist --playlist-start 1 --playlist-end 3 "%url%"

REM OPUS FORMAT
::yt-dlp --format bestaudio --extract-audio --audio-quality 160K --output "Z:\Music\!NewMusic\%%(playlist_index)s - %%(title)s.%%(ext)s" --yes-playlist "%url%"

pause
goto menu


REM ########################################################################################
REM [- 7 -]
REM ########################################################################################

:download_playlist_video
cls
ECHO [ YouTube-DLP Playlist (MP4 Video) ]
echo.

SETLOCAL DISABLEDELAYEDEXPANSION
set /P url="Enter Video Playlist ID or URL: "
yt-dlp.exe --rm-cache-dir -ciw -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" -o "D:\Downloads\YouTubeDL\%%(playlist_index)s - %%(title)s.%%(ext)s" --download-archive "D:\Temp\YouTubeDL\downloaded.txt" -v --yes-playlist "%url%"

REM yt-dlp.exe --rm-cache-dir -ciw -S res:720 -S ext:mp4 -o "D:\Downloads\YouTubeDL\%%(playlist_index)s - %%(title)s.%%(ext)s" --download-archive "D:\Temp\YouTubeDL\downloaded.txt" -v --yes-playlist "%url%"

pause
goto menu


REM ########################################################################################
REM [- 8 -]
REM ########################################################################################

:download_timespan
cls
ECHO [ YouTube-DLP TimeSpan (MP4 Video) ]
echo.

SETLOCAL DISABLEDELAYEDEXPANSION
set /P url="Enter Timespan Video URL: "
set /P time_start="Enter Start Time: "
set /P time_end="Enter End Time: "
echo.
yt-dlp.exe --rm-cache-dir -ciw --format "bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4 --download-sections "*%time_start%-%time_end%" -o "D:\Downloads\%%(title)s.%%(ext)s" %url%

pause
goto menu


REM ########################################################################################
REM [- 9 -]
REM ########################################################################################

:download_video_best_proxy
cls
ECHO [ YouTube-DLP Socks5 Proxy (4K/MP4 Video) ]
echo.

SETLOCAL DISABLEDELAYEDEXPANSION
set /P url="Enter Video URL: "
echo DEPRECATED
::yt-dlp.exe --rm-cache-dir -ciw --proxy socks5://185.206.224.39:80 --format "bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4 -o "D:\Downloads\%%(title)s.%%(ext)s" %url%

pause
goto menu