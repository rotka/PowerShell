Function add_esxi_to_vcsa {

# Error Log
$Outfile = ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + "-transcript-log.txt")

$ErrorActionPreference = "silentlycontinue"

## Add ESXi
Find-Module -Name VMware.PowerCLI
Install-Module -Name VMware.PowerCLI -Scope CurrentUser

# For the test we disable the Invalid Certificate Action during powercli's connexion 
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false

 # We need to provide an vCenter or ESXi Host
Write-Host " Entrez le Hostname / @IP du vCenter auquel se connecter " -ForegroundColor Magenta -NoNewline; $vcenter=Read-Host " "

# Connecting to the Host
Connect-VIServer –server $vcenter -ForegroundColor Cyan


# We get info from Host
Get-VMHost -Server $vcenter
$DC=Get-Datacenter
Get-Datastore -Datacenter $DC
Get-VirtualSwitch -Datacenter $DC

Write-Host "Veuillez Renseigner le Hostname de l'Hôte ESXi" -ForegroundColor Magenta -NoNewline; $esxiname = Read-Host " "

Write-Host "Veuillez Renseigner l'Administrateur de l'hyperviseur" -ForegroundColor Magenta -NoNewline; $esxiuser = Read-Host " "

Write-Host "Veuillez Renseigner le mot de passe de l'Administrateur" -ForegroundColor Magenta -NoNewline; $esxipwd = Read-Host " "

Write-Host "Veuillez Renseigner le Cluster" -ForegroundColor Magenta -NoNewline; $cluster = Read-Host " "



Add-VMHost -Name $esxiname -Location $cluster -User $esxiuser -Password $esxipwd -Force

$ifpresent = Get-VMHost $esxiname

if($ifpresent -eq $esxiname){
Write-Host "ESXi ajouté" -ForegroundColor Green
}else{
Write-Host "Echec de l'ajout" -ForegroundColor Red
}



}