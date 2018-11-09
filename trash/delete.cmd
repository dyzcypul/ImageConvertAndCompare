echo deleting tga files

for /r %%x in (*.tga) do del "%%x" /f /q

echo done deleting

PAUSE