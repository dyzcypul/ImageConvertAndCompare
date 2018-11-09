$env:Path = $Env:Path,"C:\Program Files\ImageMagick-7.0.8-Q16"

# 'reset loc' for recursive file scrapes
Set-Location D:\compare\minimaps

Get-Location 

$startLoc = (Get-Item -Path ".\").FullName
$currLoc = $startLoc

if (-Not (Test-Path "$($currloc)\logs" -PathType Container)) {
	New-Item logs -ItemType Directory
}
$logfile = "$($currLoc)\logs\converter_$($(Get-Date).ToString('yyyyddMMhhmm')).log"

Function LogWrite
{
   Param ([string]$logstring)

   Add-content $logfile -value $logstring
}


"Converting from BLP to TGA"
"__________________________"
LogWrite "Converting from BLP to TGA"
LogWrite "__________________________"
# Initial conversion from BLP to TGA using BLP.exe
Start-Process cmd -Argument "/c blip.bat" -NoNewWindow -Wait | Out-Null

# build TGA hashtables
(($valueTestTGA = @(Get-ChildItem -Recurse -Filter *.tga -Path '.\test' | Select-Object -ExpandProperty FullName)) -join ',') | Out-Null
(($valueRefTGA = @(Get-ChildItem -Recurse -Filter *.tga -Path '.\ref' | Select-Object -ExpandProperty FullName)) -join ',') | Out-Null

# building the hashtable of the 'non-reference' or 'files to be tested against reference'
$testTGA = @{}
for ($i=0; $i -lt $valueTestTGA.Count; $i++) {
	$currLoc = (Get-Item -Path $valueTestTGA[$i]).DirectoryName
	$keyParent = (Get-Item $currLoc).Parent.FullName
	$regex = [regex]::escape("$($keyParent)\")
	$thisLoc = $currLoc -replace $regex,""
	$tgaVal = [io.path]::GetFileNameWithoutExtension($valueTestTGA[$i])
	$keyTestTGA = Join-Path "$($thisLoc)" $tgaVal
	$testTGA["$keyTestTGA"] = $valueTestTGA[$i]
	Write-Host "Added key: $($keyTestTGA) and value: $($valueTestTGA[$i]) to the Test file hashtable"
	LogWrite "Added key: $($keyTestTGA) and value: $($valueTestTGA[$i]) to the Test file hashtable"
}
Clear-Host
LogWrite ""
LogWrite ""

# building the hashtable of the 'reference' files
$refTGA = @{}
for ($i=0; $i -lt $valueRefTGA.Count; $i++) {
	$currLoc = (Get-Item -Path $valueTestTGA[$i]).DirectoryName
	$keyParent = (Get-Item $currLoc).Parent.FullName
	$regex = [regex]::escape("$($keyParent)\")
	$thisLoc = $currLoc -replace $regex,""
	$tgaVal = [io.path]::GetFileNameWithoutExtension($valueRefTGA[$i])
	$keyRefTGA = Join-Path "$($thisLoc)" $tgaVal
	$refTGA["$keyRefTGA"] = $valueRefTGA[$i]
	Write-Host "Added key: $($keyRefTGA) and value: $($valueRefTGA[$i]) to the Reference file hashtable"
	LogWrite "Added key: $($keyRefTGA) and value: $($valueRefTGA[$i]) to the Reference file hashtable"
}
Clear-Host
LogWrite ""
LogWrite ""

# convert test TGAs to PNGs using ImageMagick
"Converting test from TGA to PNG"
"__________________________"
LogWrite "Converting test from TGA to PNG"
LogWrite "__________________________"
foreach ($key in $testTGA.GetEnumerator()) { 
	$destPath = Join-Path (Split-Path -Parent $key.Value) ([io.path]::GetFileNameWithoutExtension($key.Value)+'.png')
	magick convert tga:"$($key.Value)" png:$destPath
	Write-Host $key.Value + '  >>>  ' + $destPath
	LogWrite $key.Value + '  >>>  ' + $destPath
}
LogWrite "__________________________"

Clear-Host
LogWrite ""
LogWrite ""
# convert reference TGAs to PNGs using ImageMagick
"Converting ref from TGA to PNG"
"__________________________"
LogWrite "Converting ref from TGA to PNG"
LogWrite "__________________________"

foreach ($key in $refTGA.GetEnumerator()) { 
	$destPath = Join-Path (Split-Path -Parent $key.Value) ([io.path]::GetFileNameWithoutExtension($key.Value)+'.png')
	magick convert tga:"$($key.Value)" png:$destPath
	Write-Host $key.Value + '  >>>  ' + $destPath
	LogWrite $key.Value + '  >>>  ' + $destPath
}

Clear-Host
LogWrite ""
LogWrite ""
# build PNG arrays
Set-Location $startLoc
(($valueTestPNG = @(Get-ChildItem -Recurse -Filter *.png -Path '.\test' | Select-Object -ExpandProperty FullName)) -join ',') | Out-Null
(($valueRefPNG = @(Get-ChildItem -Recurse -Filter *.png -Path '.\ref' | Select-Object -ExpandProperty FullName)) -join ',') | Out-Null

# build PNG hashes
$testPNGs = @{}
for ($i=0; $i -lt $valueTestPNG.Count; $i++) {
	$currLoc = (Get-Item -Path $valueTestPNG[$i]).DirectoryName
	$keyParent = (Get-Item $currLoc).Parent.FullName
	$regex = [regex]::escape("$($keyParent)\")
	$thisLoc = $currLoc -replace $regex,""
	$pngVal = [io.path]::GetFileNameWithoutExtension($valueTestPNG[$i])
	$keyTestPNG = Join-Path "$($thisLoc)" $pngVal
	$testPNGs["$keyTestPNG"] = $valueTestPNG[$i]
	Write-Host "Added key: $($keyTestPNG) and value: $($valueTestPNG[$i]) to the Test file hashtable"
	LogWrite "Added key: $($keyTestPNG) and value: $($valueTestPNG[$i]) to the Test file hashtable"
}

Clear-Host
LogWrite ""
LogWrite ""

$refPNGs = @{}
for ($i=0; $i -lt $valueRefPNG.Count; $i++) {
	$currLoc = (Get-Item -Path $valueRefPNG[$i]).DirectoryName
	$keyParent = (Get-Item $currLoc).Parent.FullName
	$regex = [regex]::escape("$($keyParent)\")
	$thisLoc = $currLoc -replace $regex,""
	$pngVal = [io.path]::GetFileNameWithoutExtension($valueRefPNG[$i])
	$keyRefPNG = Join-Path "$($thisLoc)" $pngVal
	$refPNGs["$keyRefPNG"] = $valueRefPNG[$i]
	Write-Host "Added key: $($keyRefPNG) and value: $($valueRefPNG[$i]) to the Reference file hashtable"
	LogWrite "Added key:$($keyRefPNG) and value: $($valueRefPNG[$i]) to the Reference file hashtable"
}

Clear-Host
LogWrite ""
LogWrite ""

# running the compare algorithm
"Finding Diffs"
"__________________________"

LogWrite "Finding Diffs"
LogWrite "__________________________"

Get-Location
$currLoc = 

foreach ($test in $testPNGs.GetEnumerator()) { 
	Get-Location
	if ($refPNGs.ContainsKey($test.Key)) {
		$refVal = $refPNGs[$test.Key].ToString()
	}
		$testVal = $test.Value.ToString()
		$currLoc = (Get-Item $testVal).Directory.FullName
		if (-Not (Test-Path "$($currloc)\diffs" -PathType Container)) {
			New-Item "$($currloc)\diffs" -ItemType Directory
			Write-Host "Created 'diffs' subdirectory in $($currLoc)"
			Write-Host ""
			Start-Sleep -Milliseconds 100
		}
		$diffFiles = "$($currloc)\diffs\$($([io.path]::GetFileNameWithoutExtension($testVal)))_diff.jpg"
		
		magick compare $testVal $refVal $diffFiles
		
		$diffDest = (Split-Path -Path $test.Value).ToString()
		Write-Host "$($diffFiles) written to $($diffDest)\"
		LogWrite "$($diffFiles) written to $($diffDest)\"

		Set-Location -Path (Get-Item $testVal).Directory.FullName
		$currLoc = Get-Location
		if (Test-Path 'diffs' -PathType Container) {
			
			Move-Item *.jpg -Force -Destination "$($currLoc)\diffs"
			Start-Sleep -Milliseconds 20
			
			Write-Host "Moved $($diffFiles) to $($diffDest)\diffs\"
			LogWrite "Moved $($diffFiles) to $($diffDest)\diffs\"
			}
	
		ELSE {
	
			New-Item diffs -ItemType Directory

			# Set-Location -Path (Get-Item $currLoc).Directory.Parent.FullName
			# $currLoc = Get-Location

			Write-Host "Created 'diffs' subdirectory in $($diffDest)"
			Write-Host ""

			LogWrite "Created 'diffs' subdirectory in $($diffDest)"
			LogWrite ""

			Start-Sleep -Milliseconds 100
			
			(Get-ChildItem -Filter *.jpg | ForEach-Object {Move-Item *.jpg -Force -Destination "$($currLoc)\diffs"} )
			Write-Host "Moved $($diffFiles) to $($diffDest)\diffs\"
			Write-Host ""

			LogWrite "Moved $($diffFiles) to $($diffDest)\diffs\"
			LogWrite ""	
		}
	}