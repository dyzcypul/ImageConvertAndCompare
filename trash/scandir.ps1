function blipEXE {"W:\projects\WoW\Tools\Blip.exe"}
Set-Alias blip blipEXE
# $blp = "*.blp"
# function blips($path = $pwd, [string[]]$ext) {

$blipDir = Get-ChildItem $path -Recurse -Include *.blp | Select-Object Directory -Unique

# ForEach ($dir in $blipDir) {
#     & "W:\projects\WoW\Tools\Blip.exe" -n $dir*.blp
# }


foreach ($dir in $blipDir)
{
    $newpath = Split-Path $dir -Qualifier
    $newpath
    Set-Location ($newpath) -PassThru
    # Set-Location -Path ($blipPath) -PassThru
    # & "W:\projects\WoW\Tools\Blip.exe" -n *.blp
}


# $tgaFiles = Get-ChildItem -Recurse $scanPath -include *.tga
# function gimpEXE {"C:\Program Files\GIMP 2\bin\gimp-console-2.8.exe"}

# ForEach ($file In $tgaFiles)
# {
#     Write-Output $file.FullName 
#     gimpEXE -i -b "(script-fu-convert-file "$file" "$file_diff.png")" -b "(gimp-quit 0)"
# }

    # if($fileLineNumber -le 0){
    #     #file is empty, do nothing
    #     }
    # elseif($fileLineNumber -eq 1){
    #     # if file has one line only: trim it
    #     $fileContent = $fileContent.trimEnd()
    #     }
    # else{# file has more than 1 line        
    #     # if normalizeEOL, iterate through lines, trim each line
    #     if($normalizeEOL){ 
    #         for($i=0; $i -lt $fileLineNumber; $i++){$fileContent[$i] = $fileContent[$i].trimEnd()} 
    #     }
    #     # while last line is empty or contains white space only, decrease fileLineNumber and copy back fileContent without last line
    #     while([string]::IsNullOrWhitespace($fileContent[$fileLineNumber-1])){ 
    #         $fileLineNumber--
    #         $fileContent = $fileContent[0..($fileLineNumber-1)] 
    #     }
    # }
    # # write back modified fileContent to file    
    # Set-Content $file $fileContent
# }
    # }