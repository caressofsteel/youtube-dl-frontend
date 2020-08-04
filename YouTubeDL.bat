
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
REM
REM #########################################################################################
REM
REM YouTube-DL Front-End
REM	Binary located in C:\Apps\Liberkey\MyApps\YouTubeDL
REM #########################################################################################

SET VERSION=2020/06/16 (WEBP Fix #25717)

cls
goto menu

:menu
cls
echo.
echo  .: YouTube-DL v%VERSION% :.
echo.        
echo ### CHOOSE FORMAT ######################################################################
echo.         
	echo [ 1 ] - Audio (MP3)
	echo [ 2 ] - Video (MP4)
	echo [ 3 ] - Video (Best, MP4)
	echo [ 4 ] - Video (Choose Format)
	echo [ 5 ] - Channel (Video, MP4)
	echo [ 6 ] - Playlist (Audio, MP3)
	echo [ 7 ] - Playlist (Video, MP4)
	echo [ 8 ] - Time Span (Video, MP4)
	echo [ 9 ] - Video (Proxy, Best, MP4)
	echo [ 0 ] - Update YouTube-DL
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
ECHO [ YouTube-DL (UPDATE) ]
echo.

youtube-dl.exe -U
REM pip install --upgrade youtube-dl
REM copy /y C:\Apps\Python\Scripts\youtube-dl.exe C:\Apps\LiberKey\MyApps\YouTubeDL\
REM copy /y C:\Apps\Python\Scripts\youtube-dl-script.py C:\Apps\LiberKey\MyApps\YouTubeDL\

REM 2020-08-04: WEBPFix: https://github.com/ytdl-org/youtube-dl.git@refs/pull/25717/head
REM pip install git+https://github.com/ytdl-org/youtube-dl.git@refs/pull/25717/head

pause
goto menu


REM ########################################################################################
REM [- 1 -]
REM ########################################################################################

:download_audio
cls
ECHO [ YouTube-DL Audio ]
echo.
set /P url="Enter Audio URL: "
youtube-dl.exe -ciw -o "Z:\Music\!NewMusic\%%(title)s.%%(ext)s" -x --audio-format mp3 --embed-thumbnail --rm-cache-dir %url%
pause
goto menu


REM ########################################################################################
REM [- 2 -]
REM ########################################################################################

:download_video
cls
ECHO [ YouTube-DL Video ]
echo.
set /P url="Enter Video URL: "
youtube-dl.exe --rm-cache-dir -ciw -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" -o "D:\Downloads\%%(title)s.%%(ext)s" %url%
pause
goto menu


REM ########################################################################################
REM [- 3 -]
REM ########################################################################################

:download_video_best
cls
ECHO [ YouTube-DL (4K, MP4) ]
echo.
set /P url="Enter Video URL: "
youtube-dl.exe --rm-cache-dir -ciw --format "bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4 -o "D:\Downloads\%%(title)s.%%(ext)s" %url%
pause
goto menu


REM ########################################################################################
REM [- 4 -]
REM ########################################################################################

:download_video_format
cls
ECHO [ YouTube-DL Video (Choose Format) ]
echo.
set /P url="Enter Video URL: "
youtube-dl.exe -F %url%
pause
set /p vformat="Enter Video Code: "
set /p aformat="Enter Audio Code: "
youtube-dl.exe --rm-cache-dir -ciw -f "%vformat%+%aformat%" --download-archive D:\Downloads\downloaded.txt --merge-output-format mp4 -o "D:\Downloads\%%(title)s.%%(ext)s" %url%
pause
goto menu


REM ########################################################################################
REM [- 5 -]
REM ########################################################################################

:download_channel
cls
ECHO [ YouTube-DL Channel (MP4) ]
echo.
set /P url="Enter Channel URL: "
youtube-dl.exe --rm-cache-dir -ciw -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" -o "D:\Video\Project\YouTubeDL\%%(title)s.%%(ext)s" --download-archive "D:\Video\Project\YouTubeDL\downloaded.txt" -v %url%
pause
goto menu


REM ########################################################################################
REM [- 6 -]
REM ########################################################################################

:download_playlist
cls
ECHO [ YouTube-DL Playlist (MP3, Audio) ]
echo.
set /P url="Enter Audio Playlist ID or URL: "
youtube-dl --rm-cache-dir -ciw -o "Z:\Music\!NewMusic\%%(playlist_index)s - %%(title)s.%%(ext)s" -x --audio-format mp3 --embed-thumbnail --yes-playlist "%url%"
pause
goto menu


REM ########################################################################################
REM [- 7 -]
REM ########################################################################################

:download_playlist_video
cls
ECHO [ YouTube-DL Playlist (MP4, Video) ]
echo.
set /P url="Enter Video Playlist ID or URL: "

youtube-dl.exe --rm-cache-dir -ciw -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" -o "D:\Downloads\YouTubeDL\%%(playlist_index)s - %%(title)s.%%(ext)s" --download-archive "D:\Video\Project\YouTubeDL\downloaded.txt" -v --yes-playlist "%url%"

pause
goto menu


REM ########################################################################################
REM [- 8 -]
REM ########################################################################################

:download_timespan
cls
ECHO [ YouTube-DL TimeSpan (MP4) ]
echo.
REM set /P url="Enter Timespan Video URL: "
REM set /P time_start="Enter Start Time: "
REM set /P time_end="Enter End Time: "

echo Not Yet Implemented
echo.

pause
goto menu


REM ########################################################################################
REM [- 9 -]
REM ########################################################################################

:download_video_best_proxy
cls
ECHO [ YouTube-DL (Proxy, 4K, MP4) ]
echo.
set /P url="Enter Video URL: "
youtube-dl.exe --rm-cache-dir -ciw --proxy socks5://10.10.10.1:1080 --format "bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4 -o "D:\Downloads\%%(title)s.%%(ext)s" %url%
pause
goto menu
