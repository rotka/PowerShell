### New Ad Computer

Function create_new_adcomputer {

    # Error Log
    $Outfile = ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + "-transcript-log.txt")
    $ErrorActionPreference = "silentlycontinue"
    Write-Host "Veuillez Renseigner le Nom d'hote du Poste Informatique" -ForegroundColor Cyan -NoNewline; $ComputerName = Read-Host " "
    $pc = Get-ADComputer -Filter 'Name -eq $ComputerName'
   
    if ($pc=$ComputerName) {
        Remove-ADComputer -Identity $ComputerName | Out-File -FilePath $Outfile -Encoding utf8 -Append
        Write-Host "L'ancien Poste à été supprimé" -ForegroundColor Green
        New-ADComputer -Name "$ComputerName" -Path "OU=Ordinateurs,DC=wallmart,DC=esgi" | Out-File -FilePath $Outfile -Encoding utf8 -Append
        Write-Host "Le Nouveau Poste à été créé" -ForegroundColor Green
    }else {
        New-ADComputer -Name "$ComputerName" -Path "OU=Ordinateurs,DC=wallmart,DC=esgi" | Out-File -FilePath $Outfile -Encoding utf8 -Append
        Write-Host "Le Nouveau Poste à été créé" -ForegroundColor Green
    }
}