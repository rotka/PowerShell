Function create_vmware_cluster {

# Error Log
$Outfile = ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + "-transcript-log.txt")

$ErrorActionPreference = "silentlycontinue"

[uint16]$nbclustertodeploy = Read-Host -Prompt 'Veuillez entrer le nombre de cluster à déployer'
$a=0
$nbcluster=1

do{


$newcluster = Read-Host "Veuillez Renseigner le Cluster"
$folder = Read-Host "Veuillez Renseigner le Datacenter"
###

Write-host "Veuillez Renseigner le mode du DRS" -ForegroundColor Green
Write-host "[1]- FullyAutomated" -ForegroundColor Yellow
Write-host "[2]- Manual" -ForegroundColor Yellow
Write-host "[3]- PartiallyAutomated" -ForegroundColor Yellow

$drsmode = Read-host "Veuillez Renseigner le mode du DRS [FullyAutomated]"
Switch($drsmode){
    
    1{$drsmode = "FullyAutomated"}
    2{$drsmode = "Manual"}
    3{$drsmode = "PartiallyAutomated"}
}

###
Write-host "Veuillez Renseigner le mode du HA" -ForegroundColor Green
Write-host "[1]- Disabled" -ForegroundColor Yellow
Write-host "[2]- Low" -ForegroundColor Yellow
Write-host "[3]- Medium" -ForegroundColor Yellow
Write-host "[4]- High"-ForegroundColor Yellow

$hapriority = Read-host "Veuillez Renseigner le mode du HA"

Switch($hapriority){
    
    1{$hapriority = "Disabled"}
    2{$hapriority = "Low"}
    3{$hapriority = "Medium"}
    4{$drsmhapriorityode = "High"}
}

New-Cluster -Location $folder -Name $newcluster'-'$nbcluster -DRSEnabled:$true -DRSMode $drsmode -HAEnabled:$true -HARestartPriority $hapriority

$a++
$nbcluster=$nbcluster+2

}until($a -eq $nbclustertodeploy)
}