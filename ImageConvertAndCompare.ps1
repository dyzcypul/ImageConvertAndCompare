$env:Path = $Env:Path,"C:\Program Files\ImageMagick-7.0.8-Q16"

# remove or alter this Set-Location for production environments
Set-Location D:\compare\minimaps

# 'reset loc' for recursive file scrapes
$startLoc = (Get-Item -Path ".\").FullName

# Initial conversion from BLP to TGA using BLP.exe
"Converting from BLP to TGA"
"__________________________"
Start-Process cmd -Argument "/c blip.bat" -NoNewWindow -Wait | Out-Null

# build TGA hashtable
$valueTestTGA = (Get-ChildItem -Recurse -Filter *.tga -Path '.\test' | Select-Object -ExpandProperty FullName)
$keyTestTGA = Join-Path $startLoc $valueTestTGA
$testTGA = @{$keyTestTGA=$valueTestTGA}

$valueRefTGA = (Get-ChildItem -Recurse -Filter *.tga -Path '.\ref' | Select-Object -ExpandProperty FullName)
$keyRefTGA = Join-Path $startLoc $valueLocTGA
$refTGA = @{$keyRefTGA=$valueRefTGA}

# convert local TGAs to PNGs using ImageMagick
"Converting Local from TGA to PNG"
"__________________________"
for ($i=0; $i -lt $testTGA.Count; $i++) {
    $diffTGAs = $testTGA[$i]
	magick convert tga:$diffTGAs png:$diffTGAs.png
	$testTGA[$i] + '  >>>  ' + [io.path]::GetFileNameWithoutExtension($diffTGAs)+'.png'
}

# convert AMS TGAs to PNGs using ImageMagick
"Converting AMS from TGA to PNG"
"__________________________"
for ($i=0; $i -lt $refTGA.Count; $i++) {
    $aDiffTGAs = $refTGA[$i]
	magick convert tga:$aDiffTGAs png:$aDiffTGAs.png
	$refTGA[$i] + '  >>>  ' + [io.path]::GetFileNameWithoutExtension($aDiffTGAs)+'.png'
}

# in case stupid file names
Set-Location $startLoc
Get-ChildItem -Filter *.tga.png -Recurse -Path .\  | Rename-Item -Force -NewName { $_.name -Replace '\.tga.png$','.png' } -EA SilentlyContinue
Get-ChildItem -Filter *.tga.png -Recurse -Path .\  | Remove-Item -Force

# build PNG arrays
($localPNGs = @(Get-ChildItem -Recurse -Filter *.png -Path '.\local' | Select-Object -ExpandProperty FullName )) -join ','| Out-Null
($amsPNGs = @(Get-ChildItem -Recurse -Filter *.png -Path '.\AMS' | Select-Object -ExpandProperty FullName)) -join ',' | Out-Null

# test for loops - not needed for production
# "Local Files"
# "__________________________"
# for ($i=0; $i -le $localPNGs.Length; $i++) {
# $localPNGs[$i]
# }
# "__________________________"
# " "
# " "

# "AMS Files"
# "__________________________"
# for ($i=0; $i -le $amsPNGs.Length; $i++) {
# $amsPNGs[$i]
# }
# "__________________________"
# " "
# " "

# running the compare algorithm
"Finding Diffs"
"__________________________"
for ($i=0; $i -lt (@($localPNGs).Count); $i++) {
    $localFiles = $localPNGs[$i]
    $amsFiles = $amsPNGs[$i]

	"Comparing $($localFiles) and $($amsFiles)"
    magick compare $localFiles $amsFiles $localFiles"_diff".jpg

	# let's put all this stuff in a single folder
	Set-Location -Path (Get-Item $localFiles).Directory.FullName
	if (Test-Path 'diffs' -PathType Container) {
		Move-Item *.jpg -Force -Destination diffs
		}
	ELSE {
		New-Item diffs -ItemType Directory | Get-ChildItem -Filter *.jpg | ForEach-Object {Move-Item -Force -Destination diffs}
		}

	Get-ChildItem -Filter *.jpg | Rename-Item -Force -NewName { $_.name -Replace '\.png_diff.jpg$','_diff.jpg' } -EA SilentlyContinue
}

# more stupid file names and nuking files
Set-Location $startLoc
Get-ChildItem -Filter *.png_diff.jpg -Recurse | Rename-Item -NewName { $_.name -Replace '\.png_diff.jpg$','_diff.jpg' } -EA SilentlyContinue
Get-ChildItem -Filter *.png_diff.jpg -Recurse | Remove-Item -Force