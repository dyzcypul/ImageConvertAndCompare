($commaList = (Get-ChildItem -Recurse -Path '.\' | Select-Object -ExpandProperty Name)) -join ','
$commaList[0,1,5]
