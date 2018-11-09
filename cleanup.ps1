Set-Location D:\GhostHub\binboden\ImageConvertAndCompare\

# Get-ChildItem -Recurse -Path $loc -Force | Where-Object {!($_.PSIsContainer) -and ($name -notcontains $_.Name)} | Remove-Item -Recurse Force

# Get-ChildItem * -Exclude *.blp -Recurse | Remove-Item -Exclude *.blp,*.ps1.*.bat -Force -Recurse

Get-ChildItem -Filter *.jpg -Recurse | Remove-Item -Force
Get-ChildItem -Filter ".\diffs" -Recurse | Remove-Item -Force