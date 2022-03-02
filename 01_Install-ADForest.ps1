net accounts /maxpwage:unlimited
$DomainName = Read-Host ("`nEnter domain name - example AD.Contoso.com")
$Netbios = Read-Host ("`nEnter netbios name - example Contoso")

$ChoseDomainMode = Read-Host ("`nChose domain mode:`n`n1 2012`n2 2012R2`n3 2016`n`nEnter 1 - 3`n")

Switch ($ChoseDomainMode) {

1 {
$DomainMode = "5"
}

2 {
$DomainMode = "6"
}

3 {
$DomainMode = "7"
}
}

$ChoseForestMode = Read-Host ("`nChose forest mode:`n`n1 2012`n2 2012R2`n3 2016`n`nEnter 1 - 3`n")

Switch ($ChoseForestMode) {

1 {
$ForestMode = "5"
}

2 {
$ForestMode = "6"
}

3 {
$ForestMode = "7"
}
}

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Import-Module ADDSDeployment
Install-ADDSForest `
 -CreateDnsDelegation:$false `
 -DatabasePath "C:\Windows\NTDS" `
 -DomainMode "$DomainMode" `
 -DomainName "$DomainName" `
 -DomainNetbiosName "$Netbios" `
 -ForestMode "$ForestMode" `
 -InstallDns:$true `
 -LogPath "C:\Windows\NTDS" `
 -NoRebootOnCompletion:$false `
 -SysvolPath "C:\Windows\SYSVOL" `
 -Force:$true
