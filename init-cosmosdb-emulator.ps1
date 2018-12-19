
$hostDirectory = "$env:LOCALAPPDATA\azure-cosmosdb-emulator.hostd"
$containerName = "azure-cosmosdb-emulator"
New-Item -ItemType Directory -Force -Path $hostDirectory | Out-Null

docker run --name $containerName -p 8081:8081 -h azure-cosmosdb-emulator --memory 2GB --mount "type=bind,source=$hostDirectory,destination=C:\CosmosDB.Emulator\bind-mount" -P --interactive --tty microsoft/azure-cosmosdb-emulator