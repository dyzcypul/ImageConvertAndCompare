$sourcePath = "D:\test1\test2\test3\test4"
$keyParent = (Get-Item $sourcePath).Parent.FullName
$regex = [regex]::escape("$($keyParent)\")
$sourcePath -replace $regex,""


foreach ($key in $testPNGs.GetEnumerator()) { 
	if ($testPNGs.ContainsKey($key) {
		magick compare tga:"$($key.Value)" png:$destPath	
	}
	
	$testFiles = $testPNGs($key.Value)
	$refFiles = $refPNGs($key.Value)
	$diffFiles = "$($([io.path]::GetFileNameWithoutExtension($testFiles)))_diff.jpg"

	# Write-Host "$($key.Name): $($destPath)"
	magick compare tga:"$($key.Value)" png:$destPath
	$key.Value + '  >>>  ' + $destPath
}
