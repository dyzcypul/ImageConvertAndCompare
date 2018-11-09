Get-ChildItem -Filter *png -Recurse  | Remove-Item -Force
Get-ChildItem -Filter *jpg -Recurse  | Remove-Item -Force
Get-ChildItem -Filter *tga -Recurse  | Remove-Item -Force
Get-ChildItem -Filter diffs -Recurse  | Remove-Item -Force