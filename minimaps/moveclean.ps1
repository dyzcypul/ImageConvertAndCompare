$startLoc = (Get-Item -Path ".\").FullName
Set-Location $startLoc
Get-ChildItem -Path ".\*" -Filter "*.jpg" -Recurse |  ForEach-Object {Move-Item "*.jpg" -Force -Destination ".\diffs"}