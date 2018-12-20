Set-StrictMode -Version 2
$ErrorActionPreference = 'Stop'

$PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path

. "$PSScriptRoot/common.ps1"

New-Item -ItemType Directory -Force -Path $hostDirectory | Out-Null

docker pull microsoft/azure-cosmosdb-emulator
docker run --name $containerName -p 8081:8081 -h azure-cosmosdb-emulator --memory 2GB --mount "type=bind,source=$hostDirectory,destination=C:\CosmosDB.Emulator\bind-mount" -P --interactive --tty microsoft/azure-cosmosdb-emulator