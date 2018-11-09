@echo off
SET blipEXE="W:\projects\WoW\Tools\Blip.exe"
for /r %%x in (*.blp) do ( echo ______________________________________________________________________ & echo. & %blipEXE% -n "%%x" & echo Converting "%%x" from BLP to TGA & echo ______________________________________________________________________)