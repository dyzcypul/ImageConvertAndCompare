# function notSourceFiles($path = $pwd, [string[]]$include) 
# { 
#     foreach ($item in Get-ChildItem $path -Include $include)
#     {
#         if ($include | Where-Object {$item -notlike $_})
#         {
#             continue
#         }
        
#         if (Test-Path $item.FullName) 
#         {
#             $item 
#             notSourceFiles $item.FullName $include
#             Write-Output $item
#             Set-PSBreakpoint
#         } 
#         else 
#         { 
#             $item 
#         }
#     } 
# }

# notSourceFiles d:\compare\ *.jpg

function notSourceFiles($path = $pwd, [string[]]$exclude) 
{ 
    foreach ($item in Get-ChildItem $path)
    {
        if ($exclude | Where-Object {$item -like $_}) { continue }

        if (Test-Path $item.FullName -PathType Container) 
        {
            $item 
            notSourceFiles $item.FullName $exclude
        } 
        else 
        { 
            $item 
        }
    } 
}

notSourceFiles d:\compare\ *.jpg,*.png,*.ps1,*.cmd,*.tga

Write-Output notSourceFiles;