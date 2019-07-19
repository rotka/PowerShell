Function create_export_vm {

$name
$


Write-Host "veuillez entrer le nom de la vm" -ForegroundColor Cyan -NoNewline; $name = Read-Host ""

Write-Host "voulez vous supprimer les snapshots existantes de la vm? [y/n]" -ForegroundColor Cyan -NoNewline; $removesnapshot = read-host ""

if ($removesnapshot -eq "y"){
# remove snapshots
Get-VM -Name Test-VM | Shutdown-VMGuest -confirm:$false
Write-Host "snapshot correctement supprimée" -ForegroundColor Gren
Get-VM -Name $name | Get-CDDrive | Set-CDDrive -NoMedia -confirm:$false
Write-Host "le disque [CDROM] a bien été démonté" -ForegroundColor Gren
}else{
#remove cd drive
Get-VM -Name $name | Get-CDDrive | Set-CDDrive -NoMedia -confirm:$false
Write-Host "le disque [CDROM] a bien été démonté" -ForegroundColor Gren
}
# make export
Get-VM -Name $name | Export-VApp -Destination ‘\‘ -Format OVA
Write-Host "la snapshot a correctement été réalisée" -ForegroundColor Gren

}