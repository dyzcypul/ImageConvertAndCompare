Set-Location D:\minimaps\ref\World\Minimaps

Get-ChildItem -Filter *.tga -Recurse | Remove-Item -Force
Get-ChildItem -Filter *.png -Recurse | Remove-Item -Force
Get-ChildItem -Filter *.jpg -Recurse | Remove-Item -Force

Set-Location D:\minimaps\test\
Get-ChildItem -Filter ".\diffs" -Recurse | Remove-Item -Force