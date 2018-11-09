$localFiles = Get-ChildItem "C:\Users\smchow\Desktop\Minimaps Local" -Filter *.png;
$amsFiles = Get-ChildItem "C:\Users\smchow\Desktop\Minimaps AMS" -Filter *.png;

#old blip code

& cmd
SET blipEXE="W:\projects\WoW\Tools\Blip.exe"
for /r %x in (*.blp) do %blipEXE% -n "\%%x\"
exit

# # looping for gimp blips
# function getSourceFiles($path = $pwd, [string[]]$include) 
# { 
#     foreach ($item in Get-ChildItem $path)
#     {
#         if ($include | Where-Object {$item -notlike $_}) { continue }

#         if (Test-Path $item.FullName -PathType Container) 
#         {
#             $item 
#             getSourceFiles $item.FullName $include
#         } 
#         else 
#         { 
#             $item 
#         }
#     } 
# }

# getSourceFiles . *.jpg

# Write-Output getSourceFiles;

"Test Files"
for ($i=0; $i -le $localFiles.Count; $i++) {
Write-Output $localFiles[$i].FullName
};

"AMS Files"
for ($i=0; $i -le $amsFiles.Count; $i++) {
Write-Output $amsFiles[$i].FullName
};

for ($i=0; $i -lt $localFiles.Count; $i++) {
    $diffFiles = $localFiles[$i];
    magick compare $localFiles[$i].FullName $amsFiles[$i].FullName $diffFiles"_diff".jpg
    Move-Item *.jpg -Destination "C:\Users\smchow\Desktop\Minimaps Difference\"
    $diffFiles;
};
"Output files"
for ($i=0; $i -le $diffFiles.Count; $i++) {
    if (!(!$diffFiles))
    {
    Write-Output $diffFiles[$i].FullName
    }
    else {
        "No output"
    }
};
