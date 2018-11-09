& cmd {SET blipEXE="W:\projects\WoW\Tools\Blip.exe"
(for /r %%x in (*.blp) do %blipEXE% -n "\%x\")
exit}