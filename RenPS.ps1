Get-Date -uformat "%Hh%M(%S) : DEBUT DU SCRIPT POWERSHELL`n"
$code_region = $args[0]
$dir = $args[1]

if ($args.Count -lt 2)
		{
			Get-Date -uformat "%Hh%M(%S) : ERR. : Argument manquant' - code_region dossier"
			exit 10
		}
$folders = gci $dir -Recurse | Where-Object {$_.name -like "Prefix_*" -and $_.PSIsContainer -and $_.name -notmatch "Prefix_1"}
foreach ($folder in $folders)
	{
Get-Childitem $folder.FullName -Recurse | where-object {!$_.PSIsContainer} | ForEach {  
    $timestamp = Get-Date -f yyyyMMdd           
    Rename-Item $_.FullName $code_region-$timestamp-$_"-test.txt"
    write-host "Fichier:" $_.FullName "devient:" $code_region-$timestamp-$_"-test.txt"
    Start-Sleep -s 1
}

}
Get-Date -uformat "`n%Hh%M(%S) : FIN DU SCRIPT POWERSHELL"