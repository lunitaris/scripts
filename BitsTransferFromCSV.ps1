param($listeLocation)

###################################################
##
##	Realized by Lunitaris
##	This script allow transfering files between two directories specified in a CSV.
##
## This is a Powershell script.
#
# Usage: script.ps1 listeResautants.csv
# Le CSV doit etre de la forme:
#
# Source, Destination
# \\IP_source\folder\truc \\chemin_destination\folder\truc
####################################################

$date = get-date -Format dd-MM-y
Import-Module BitsTransfer

start-transcript "C:\BITStartTransferts$date.log" -append -noclobber

$Liste = Import-Csv $listeLocation

ForEach ($chemin in $Liste) {
    $targetTransfert = $chemin.Destination

    # Si le dossier date n'existe pas, on le cree.
    If (!(Test-Path $targetTransfert)) { 
       New-Item -Path $targetTransfert$l$date -ItemType Directory
       Write-Host $targetTransfert$l$date cree!
    }

      $HostSRC = $chemin.Source.split("\\") | select -First 3 # Recupère le path UNC \\HOST

    ## Start un transfert BITS Asynchrone pour chaque lignes du CSV. Le nom du transfert sera de la forme: 'From: nom_pc::30-07-2015'
    Start-BitsTransfer $chemin.Source "$targetTransfert$l$date\" -Asynchronous -DisplayName "From:$HostSRC::$date" -Description "Transfert de $HostSRC vers AUBFRBITS"

    Write-Host "============================================================================"
    Write-Host "Transfert créé: "From:$HostSRC""
    Get-BitsTransfer -Name "From:$HostSRC::$date"
    Write-Host "============================================================================"

}

Stop-Transcript

bitsadmin.exe /LIST /VERBOSE | Out-File "C:\BITS_jobs$date.log" -append -noclobber

start-process powershell -WindowStyle Maximized "bitsadmin.exe /MONITOR"

    # Write-Host "Verification de fin de transfert."
    # .\completeJOBS.ps1 # Verifie que chaque transferts est terminé (completed).
