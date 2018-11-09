
SETLOCAL

SET blipEXE="W:\projects\WoW\Tools\Blip.exe"
for /r %%x in (*.blp) do %blipEXE% -n "\%%x\"

ENDLOCAL

SETLOCAL

SET gimpEXE="c:\Program Files\GIMP 2\bin\gimp-console-2.8.exe"
for /r %%x in (*.tga) do %gimpEXE% -i -b "(script-fu-convert-file "\%%x\ "\%%x.png\")" -b "(gimp-quit 0)"

ENDLOCAL

PAUSE


 