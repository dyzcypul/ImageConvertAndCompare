# $localFiles = Get-ChildItem "C:\Users\smchow\Desktop\Minimaps Local" -Filter *.png
# $amsFiles = Get-ChildItem "C:\Users\smchow\Desktop\Minimaps AMS" -Filter *.png
# $diffFiles = Get-ChildItem "C:\Users\smchow\Desktop\Minimaps Diff" -Filter *.png

# for ($i=0; $i -lt $localFiles.Count; $i++) {
#     magick compare $localFiles[$i].FullName $amsFiles[$i].FullName $diffFiles[$i].FullName
# }


$localFiles = Get-ChildItem ".\source" -Filter *.png
$amsFiles = Get-ChildItem ".\dest" -Filter *.png
$diffFiles = Get-ChildItem ".\output" -Filter *.png

for ($i=0; $i -lt $localFiles.Count; $i++) {
    magick compare $localFiles[$i].FullName $amsFiles[$i].FullName $diffFiles[$i].FullName
}