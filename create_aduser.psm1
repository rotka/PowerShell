 ### Active Directory

 Function create_aduser {

 # Error Log
$Outfile = ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + "-transcript-log.txt")

$ErrorActionPreference = "silentlycontinue"

# Informations:
$gin = 1

# We set the user Personnal Info


# We set counter and limit
Write-Host "Entrez le nombre de User à déployer" -ForegroundColor Magenta -NoNewline; [uint16]$limit = Read-Host -Prompt ' '
$counter=0

#Get-ADUser 

Do{

Write-Host "Entrez le username de l'utilisateur" -ForegroundColor Magenta -NoNewline; $lo = Read-Host " "
$firstname="$lo"
$Lastname= "$gin"
$User=$lo+$gin

Write-Host "Entrez le mot de passe de l'utilisateur" -ForegroundColor Magenta -NoNewline; $Password = Read-Host " " -AsSecureString


Write-Host "Voulez vous supprimer l'ancien utilisateur? [y/n]" -ForegroundColor Magenta -NoNewline; $aduser = Read-Host " "

Write-Host "Voulez vous supprimer l'ancien groupe? [y/n]" -ForegroundColor Magenta -NoNewline; $adgroup = Read-Host " "

#$aduser = Get-ADUser -Filter "SamAccountName -eq '$User'" | Out-String | Select-Object SamAccountName | Out-File -FilePath $Outfile -Encoding utf8 -Append 
#$adgroup = Get-ADGroup -Filter "Name -eq 'Admin-$User'" | Select-Object SamAccountName | Out-File -FilePath $Outfile -Encoding utf8 -Append


if(($aduser -eq "y")-or($adgroup -eq "y")){

Write-Host "l'utilisateur existait déjà" -ForegroundColor Red
Remove-ADUser -Identity $User
Write-Host "l'ancien utilisateur à été supprimé" -ForegroundColor Magenta

Write-Host "le groupe existait déjà" -ForegroundColor Red
Remove-ADGroup -Identity "Admin-$User"
Write-Host "le groupe à été supprimé" -ForegroundColor Magenta

New-ADGroup -name "Admin-$User" -GroupCategory Security -GroupScope Global -DisplayName "Admins" -Description "Members of this group are Administrators" | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "Le groupe a été créé" -ForegroundColor Green

New-ADUser -name $User -UserPrincipalName $User -GivenName $firstname -Surname $Lastname -AccountPassword $Password | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "L'utilisateur a été créé avec succès" -ForegroundColor Green

Add-ADGroupMember -Identity "Admin-$User" -Member $User | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "L'utilisateur a correctement été ajouté au groupe" -ForegroundColor Green
    

}
else{

New-ADGroup -name "Admin-$User" -GroupCategory Security -GroupScope Global -DisplayName "Admins" -Description "Members of this group are Administrators" | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "Le groupe a été créé" -ForegroundColor Green

New-ADUser -name $User -UserPrincipalName $User -GivenName $firstname -Surname $Lastname -AccountPassword $Password | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "L'utilisateur a été créé avec succès" -ForegroundColor Green

Add-ADGroupMember -Identity "Admin-$User" -Member $User | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "L'utilisateur a correctement été ajouté au groupe" -ForegroundColor Green

}
    
    $confirm=$null
    $gin=$gin+2
    $counter++

$confirm = Read-Host "Voulez vous Activer l'utilisateur? [y/n]"
while($confirm -ne "y")
{
    if ($confirm -eq 'n') {exit}
    $confirm = Read-Host "Voulez vous Activer l'utilisateur? [y/n]"
}

Enable-ADAccount -Identity $User
Write-Host "L'utilisateur à été correctement activé" -ForegroundColor Green


}Until($counter -eq $limit)

Write-Host "Tache terminée !" -ForegroundColor Magenta

}