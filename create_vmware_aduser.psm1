Function create_vmware_aduser{

# Error Log
$Outfile = ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + "-transcript-log.txt")

$ErrorActionPreference = "silentlycontinue"


$vcgroup = Read-Host "Veuillez Renseigner le nom du groupe d'Administrateurs vCenter"
$VCUser = Read-Host "Veuillez Renseigner le nom de l'utilisateur à ajouter au groupe d'Administrateurs vCenter"

$appartenance = Get-ADGroupMember -Identity $VCUser
if($appartenance -eq $VCUser){
Write-Host "L'utilisateur appartient déjà au groupe: $vcgroup" -ForegroundColor Red
}else{
Write-Host "L'utilisateur n'appartenait pas au groupe: $vcgroup" -ForegroundColor Green
}

Add-ADGroupMember -Identity "$vcgroup" -Member $VCUser | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "L'utilisateur à été correctement ajouté au groupe" -ForegroundColor Green

## Activation Utilisateur

$confirmation2 = Read-Host "Voulez vous Activer l'utilisateur? [y/n]"
while($confirmation2 -ne "y")
{
    if ($confirmation2 -eq 'n') {exit}
    $confirmation2 = Read-Host "Voulez vous Activer l'utilisateur? [y/n]"
}

Enable-ADAccount -Identity "$VCUser"
Write-Host "L'utilisateur à été correctement activé" -ForegroundColor Green

}