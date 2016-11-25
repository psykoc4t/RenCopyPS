Get-Date -uformat "%Hh%M(%S) : DEBUT DU SCRIPT POWERSHELL`n"
$dir = $args[0]
$dest = "\\serveur\e$\dossier"
$count = 0
if ($args.Count -lt 1)
		{
			Get-Date -uformat "%Hh%M(%S) : ERR. : Argument manquant' - dossier"
			exit 10
		}

$folders = gci $dir -Recurse | Where-Object {$_.name -like "prefix_*" -and $_.PSIsContainer -and $_.name -notmatch "prefix_1"}
foreach ($folder in $folders)
	{
Get-Childitem $folder.FullName -Recurse | where-object {!$_.PSIsContainer} | ForEach {            
    #Copy-Item $_.FullName -Destination $dest
    write-host "Fichier:" $_.FullName "copie vers:" $dest | Out-File result.log
    Start-Sleep -s 1
    $count = $count + 1 
}

}

write-host $count "fichier(s) copie(s)"
Get-Date -uformat "`n%Hh%M(%S) : FIN DU SCRIPT POWERSHELL"