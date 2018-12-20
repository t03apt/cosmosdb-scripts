Set-StrictMode -Version 2
$ErrorActionPreference = 'Stop'

$PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path

. "$PSScriptRoot/common.ps1"

if (docker ps -aq --filter "name=$containerName" --filter "status=running"){
    throw "'$containerName' is already running"
}

$certPath = "$hostDirectory\CosmosDbEmulatorCert.cer"
if (Test-Path $certPath) {
    Remove-Item $certPath
}

docker start $containerName

Write-Host "Wait for new certificate"
for ($i = 0; $i -le 60; $i++) {
    if (Test-Path $certPath){
        break
    }
    Start-Sleep 1
}

"My", "Root" | ForEach-Object {
    Get-ChildItem "cert:\LocalMachine\$_" | 
    Where-Object { $_.DnsNameList -and ($_.DnsNameList[0] -eq $containerName) } | 
    ForEach-Object { Write-Host "Removing certificate: $($_.Thumbprint)"; return $_ } |
    Remove-Item
}

& "$hostDirectory\importcert.ps1" 