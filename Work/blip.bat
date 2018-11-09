@echo off
SET blipEXE="W:\projects\WoW\Tools\Blip.exe"
for /r %%x in (*.blp) do ( @echo %%x & echo ______________________________________________________________________ & echo. & %blipEXE% -n "%%x" & echo ______________________________________________________________________)