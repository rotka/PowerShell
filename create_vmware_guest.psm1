Function create_vmware_guest {

# Error Log
$Outfile = ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + "-transcript-log.txt")
$fileName = 'vms.csv'
$deployedhost=1
#$ErrorActionPreference = "silentlycontinue"

## Add ESXi
Find-Module -Name VMware.PowerCLI
Install-Module -Name VMware.PowerCLI -Scope CurrentUser | Format-Table

# For the test we disable the Invalid Certificate Action during powercli's connexion 
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false | Format-Table
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false | Format-Table

Write-Host " Entrez le Hostname / @IP du vcenter auquel se connecter " -ForegroundColor Magenta -NoNewline; $vcenter=Read-Host " "
Write-Host " Entrez le Hostname / @IP du esxi sur lequel déployer l'hote " -ForegroundColor Magenta -NoNewline; $host_name=Read-Host " "
Connect-VIServer –server $vcenter

$filename = 'vms.csv'

$limmit=1
$i = 0


do{

#Get-VMHost | Format-Table
#Write-Host "Entrez l'hôte ESXi cible" -ForegroundColor Cyan -NoNewline; $esxhost= Read-Host " "

Get-Datastore | Format-Table
Write-Host "Entrez le Datastore cible" -ForegroundColor Cyan -NoNewline; $datastore= Read-Host " "

Get-VirtualNetwork | Format-Table
Write-Host "Entrez le VM Network cible" -ForegroundColor Cyan -NoNewline; $vmnet= Read-Host " "

Get-Cluster | Format-Table
Write-Host "Entrez le Cluster cible" -ForegroundColor Cyan -NoNewline; $ClusterName= Read-Host " "

$vmbasicname="vm"

[uint16]$vmnb='1'
$vmname = "$vmbasicname-$ClusterName-$vmnb"



    $vm = New-VM -Name "$vmname" -VMHost "$host_name" -Datastore "$datastore" -DiskGB '1' -MemoryMB '256' -NumCpu "1" -NetworkName "$vmnet" -DiskStorageFormat "thin"
#    If we are connected to a vcenter we can also use those arguments
#    -DrsAutomationLevel $vmLine.drs - -HARestartPriority $vmLine.HA

$vmnb++
$i++

Write-Host "La machine $vmname à été déployé correctement" -ForegroundColor Green

}until($limmmit -ge $i)



Write-Host " Voulez vous vous deconnecter du vCenter? [y/n] " -ForegroundColor Magenta -NoNewline; $disconnect = Read-Host " "

if($disconnect -eq "y"){
Disconnect-VIServer –server $vcenter
Write-Host "Vous avez été correctement deconnecté" -ForegroundColor Green
}else{

Write-Host "Votre session vCenter est toujours active" -ForegroundColor Green
}

}