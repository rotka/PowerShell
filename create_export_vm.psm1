Function create_export_vm {

$name
 
Write-Host "Entrez le serveur auquel se connecter: " -ForegroundColor Cyan -NoNewline; $viservertoconnect = Read-Host " "

Connect-VIServer $viservertoconnect

Write-Host "Vous êtes connectés à $viservertoconnect" -ForegroundColor Green

Write-Host "veuillez entrer le nom de la vm" -ForegroundColor Cyan -NoNewline; $name = Read-Host " "

Write-Host "voulez vous supprimer les snapshots existantes de la vm? [y/n]" -ForegroundColor Cyan -NoNewline; $removesnapshot = read-host " "

if ($removesnapshot -eq "y"){
# remove snapshots
Get-VM -Name Test-VM | Shutdown-VMGuest -confirm:$false
Write-Host "snapshot correctement supprimée" -ForegroundColor Green
Get-VM -Name $name | Get-CDDrive | Set-CDDrive -NoMedia -confirm:$false
Write-Host "le disque [CDROM] a bien été démonté" -ForegroundColor Green
}else{
#remove cd drive
Get-VM -Name $name | Get-CDDrive | Set-CDDrive -NoMedia -confirm:$false
Write-Host "le disque [CDROM] a bien été démonté" -ForegroundColor Green
}
# make export
Get-VM -Name $name | Export-VApp -Destination ‘\‘ -Format OVA
Write-Host "la snapshot a correctement été réalisée" -ForegroundColor Green


Write-Host "Voulez - vous vous déconnecter du serveur: $viservertoconnect [y/n]" -ForegroundColor Cyan -NoNewline; $viservertodisconnect = Read-Host " "

if ($viservertodisconnect -eq "y"){
Disconnect-VIServer $viservertoconnect
Write-Host "Vous avez été correctement déconnecté" -ForegroundColor Green
}else{
Write-Host "Votre session est toujours active" -ForegroundColor Green
}

}