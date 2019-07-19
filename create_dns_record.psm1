###DNS

Function create_dns_record{

# Error Log
$Outfile = ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + "-transcript-log.txt")

$ErrorActionPreference = "silentlycontinue"

Write-Host "Veuillez Renseigner le Hostname de la machine" -ForegroundColor Cyan -NoNewline; $hostESXi = Read-Host " "

Write-Host "Veuillez Renseigner l'adresse IP de la machine" -ForegroundColor Cyan -NoNewline; $ipESXi = Read-Host " "

$ComputerName = $hostESXi

Write-Host "Veuillez Renseigner la Zone" -ForegroundColor Cyan -NoNewline; $ZoneName = Read-Host " " #"wallmart.esgi"

Add-DnsServerResourceRecordA -ZoneName $ZoneName -Name $hostESXi -IPv4Address $ipESXi | Out-File -FilePath $Outfile -Encoding utf8 -Append
Write-Host "L'entrée de $hostESXi dans la zone $ZoneName à été créé correctement" -ForegroundColor Green

}