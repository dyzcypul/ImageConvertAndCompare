Set-Location D:\GhostHub\binboden\ImageConvertAndCompareSTDOUT\ref\World\Minimaps\QA_DVD

# Get-ChildItem -Recurse -Path $loc -Force | Where-Object {!($_.PSIsContainer) -and ($name -notcontains $_.Name)} | Remove-Item -Recurse Force

# Get-ChildItem * -Exclude *.blp -Recurse | Remove-Item -Exclude *.blp,*.ps1.*.bat -Force -Recurse

Get-ChildItem -Filter *.tga -Recurse | Remove-Item -Force
Get-ChildItem -Filter *.png -Recurse | Remove-Item -Force
Get-ChildItem -Filter *.jpg -Recurse | Remove-Item -Force

Set-Location D:\GhostHub\binboden\ImageConvertAndCompareSTDOUT\test\World\Minimaps\
Get-ChildItem -Filter ".\diffs" -Recurse | Remove-Item -Force