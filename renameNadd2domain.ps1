##
## Powershell script made by Lunitaris
## It renames a computer and places it in the domain specified.

$nomPC = Read-Host 'Nom de la machine?'
$nomDom = Read-Host 'Nom complet du domain?'
$compteAdmin = Read-Host 'Compte Admin (domain\nom_compte)?'

Rename-Computer -NewName $nomPC -DomainCredential $compteAdmin  -Force -PassThru
Add-Computer -DomainName $nomDom -Credential $compteAdmin -Verbose
