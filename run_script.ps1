#!/usr/bin/env pwsh
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Folder,

    [Parameter(Mandatory=$false, Position=1)]
    [string]$ScriptOrFlag
)

function Show-Usage {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <folder> [--all | script.sql]"
    Write-Host "  <folder>      - Folder containing SQL scripts"
    Write-Host "  --all         - Run all SQL files in the folder (in alphabetical order)"
    Write-Host "  script.sql    - Run a specific SQL file from the folder"
    exit 1
}

if (-not (Test-Path -Path $Folder -PathType Container)) {
    Write-Host "Folder not found: $Folder"
    Show-Usage
}

if ($ScriptOrFlag -eq "--all") {
    Write-Host "Running all SQL files from $Folder..."
    Get-ChildItem -Path $Folder -Filter *.sql -File | Sort-Object Name | ForEach-Object {
        $file = $_.FullName
        Write-Host "Executing: $($_.Name)"
        Get-Content -Raw -Path $file | & docker exec -i postgres_bdp psql -U postgres -d postgres
        Write-Host "---"
    }
    Write-Host "All scripts executed."
}
elseif ($ScriptOrFlag) {
    $filePath = Join-Path -Path $Folder -ChildPath $ScriptOrFlag
    if (-not (Test-Path -Path $filePath -PathType Leaf)) {
        Write-Host "File not found: $filePath"
        exit 1
    }
    Write-Host "Executing: $ScriptOrFlag"
    Get-Content -Raw -Path $filePath | & docker exec -i postgres_bdp psql -U postgres -d postgres
}
else {
    Show-Usage
}