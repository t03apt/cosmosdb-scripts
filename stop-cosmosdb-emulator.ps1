Set-StrictMode -Version 2
$ErrorActionPreference = 'Stop'

$PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path

. "$PSScriptRoot/common.ps1"

docker stop $containerName