#!/usr/bin/env pwsh

gittuf verify-ref master

if ($LASTEXITCODE -eq 0) {
    Write-Output 'Repository satisfies policy.'
    exit 0
} else {
    Write-Output 'Repository doesnt satisfy poilicy'
    exit 1
}
