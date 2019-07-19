#######################################
#       GOINDIN JULIEN - 4A SRC2      #
#       MHARBI  RIM    - 4A SRC2      #
#       BARBOTIN VICTOR- 4A SRC2      #
#     OUENNOUGHI TARYL - 4A SRC2      #
#           Année 2018-2019           #
#               ESGI                  #
#######################################

# log file
# Start Transcript of PowerShell Session
Start-Transcript -Path '.\transcript.txt' -Append


# Error Log
$Outfile = ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + "-transcript-log.txt")

$ErrorActionPreference = "silentlycontinue"

###Amorce Fonctions

Import-Module –Name ".\add_esxi_to_vcsa.psm1"
Import-Module –Name ".\create_aduser.psm1"
Import-Module –Name ".\create_dns_record.psm1"
Import-Module –Name ".\create_new_adcomputer.psm1"
Import-Module –Name ".\create_vmware_aduser.psm1"
Import-Module –Name ".\create_vmware_cluster.psm1"
Import-Module –Name ".\create_vmware_guest.psm1"
Import-Module -Name ".\create_export_vm.psm1"

#Import-Module –Name ".\Get-VISession.psm1"


###Fin Fonctions


### Menu Contextuel

$compteur = 0
$limite = 1

Do{
Write-host "Veuillez Choisir parmis les options ci-dessous:" -ForegroundColor Green
Write-host "Windows Active Directory:" -ForegroundColor DarkCyan #-BackgroundColor White
Write-host "[1]- Créer un nouvel Ordinateur AD" -ForegroundColor Cyan
Write-host "[2]- Créer un Utilisateur Active Directory" -ForegroundColor Cyan 
Write-host "[3]- Créer une Entrée DNS" -ForegroundColor Cyan 
Write-host "Vmware ESXi:" -ForegroundColor DarkCyan #-BackgroundColor White
Write-host "[4]- Créer un Utilisateur Vmware" -ForegroundColor Cyan 
Write-host "[5]- Créer un Cluster Vmware" -ForegroundColor Cyan 
Write-host "[6]- Créer une nouvelle machine Virtuelle " -ForegroundColor Cyan 
Write-host "[7]- Ajouter un ESXi au vCenter" -ForegroundColor Cyan 
Write-host "[8]- Exporter une VM" -ForegroundColor Cyan 

$menu = Read-host "Choisissez une option ci-dessous"
Switch($menu){
    
    1{$menu = "create_new_adcomputer"} 
    2{$menu = "create_aduser"}
    3{$menu = "create_dns_record"}
    4{$menu = "create_vmware_aduser"}
    5{$menu = "create_vmware_cluster"}
    6{$menu = "create_vmware_guest"}
    7{$menu = "add_esxi_to_vcsa"}
    8{$menu = "create_export_vm"}
}

&$menu
$compteur++
$limite++
}until($compteur -eq $limite)