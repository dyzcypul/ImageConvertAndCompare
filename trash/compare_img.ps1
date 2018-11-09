# $localFiles = Get-ChildItem ".\source\" -Filter *.png;
# $amsFiles = Get-ChildItem ".\dest\" -Filter *.png;
# function gimpExe {"c:\Program Files\GIMP 2\bin\gimp-console-2.8.exe"};

# "Test Files"
# for ($i=0; $i -le $localFiles.Count; $i++) {
# Write-Output $localFiles[$i].FullName
# };

# "AMS Files"
# for ($i=0; $i -le $amsFiles.Count; $i++) {
# Write-Output $amsFiles[$i].FullName
# };

# for ($i=0; $i -lt $localFiles.Count; $i++) {
#     $diffFiles = $localFiles[$i];
#     magick compare $localFiles[$i].FullName $amsFiles[$i].FullName $diffFiles"_diff".jpg
#     Move-Item *.jpg -Destination ".\output\"
#     $diffFiles;
# };
# "Output files"
# for ($i=0; $i -le $diffFiles.Count; $i++) {
#     if (!(!$diffFiles))
#     {
#     Write-Output $diffFiles[$i].FullName
#     }
#     else {
#         "No output"
#     }
# };

# $localFiles = Get-ChildItem "C:\Users\smchow\Desktop\Minimaps Local" -Filter *.png;
# $amsFiles = Get-ChildItem "C:\Users\smchow\Desktop\Minimaps AMS" -Filter *.png;
# $diffFiles = "C:\Users\smchow\Desktop\Minimaps Diff" + $localFiles;


function getSourceFiles($path = $pwd, [string[]]$exclude) 
{ 
    foreach ($item in Get-ChildItem $path)
    {
        if ($exclude | Where-Object {$item -like $_}) { continue }

        if (Test-Path $item.FullName -PathType Container) 
        {
            $item 
            getSourceFiles $item.FullName $exclude
        } 
        else 
        { 
            $item 
        }
    } 
}

getSourceFiles d:\compare\ *.jpg

Write-Output getSourceFiles;

#         $diffFiles = $getSourceFiles[$i];
#         magick compare $localFiles[$i].FullName $amsFiles[$i].FullName $diffFiles"_diff".jpg
#         Move-Item *.jpg -Destination ".\output\"
#         $diffFiles;
#     };