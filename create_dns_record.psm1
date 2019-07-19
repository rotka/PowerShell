###DNS

Function create_dns_record{

# Error Log
$Outfile = ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + "-transcript-log.txt")

$ErrorActionPreference = "silentlycontinue"

Write-Host "Veuillez Renseigner le Hostname de la machine" -ForegroundColor Cyan -NoNewline; $hostESXi = Read-Host " "

Write-Host "Veuillez Renseigner l'adresse IP de la machine" -ForegroundColor Cyan -NoNewline; $ipESXi = Read-Host " "

$ComputerName = $ipESXi

Write-Host "Veuillez Renseigner la Zone" -ForegroundColor Cyan -NoNewline; $ZoneName = Read-Host " " #"wallmart.esgi"

Add-DnsServerResourceRecordA -ZoneName $ZoneName -Name $hostESXi -IPv4Address $ipESXi | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "L'entr�e de $hostESXi dans la zone $ZoneName � �t� cr�� correctement" -ForegroundColor Green


### New Ad Computer

$pc = Get-ADComputer -Filter 'Name -eq $ComputerName'

if ($pc=$ComputerName) {

Remove-ADComputer -Identity $ComputerName | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "L'ancien Poste � �t� supprim�" -ForegroundColor Green

New-ADComputer -Name "$ComputerName" -Path "OU=Ordinateurs,DC=wallmart,DC=esgi" | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "Le Nouveau Poste � �t� cr��" -ForegroundColor Green

}else {

New-ADComputer -Name "$ComputerName" -Path "OU=Ordinateurs,DC=wallmart,DC=esgi" | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "Le Nouveau Poste � �t� cr��" -ForegroundColor Green

}
}