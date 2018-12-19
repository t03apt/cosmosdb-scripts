$containerName = "azure-cosmosdb-emulator"
$hostDirectory = "$env:LOCALAPPDATA\azure-cosmosdb-emulator.hostd"

docker start $containerName
#Start-Sleep -s 5
& "$hostDirectory\importcert.ps1" 