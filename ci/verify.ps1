#!/usr/bin/env pwsh

if (-not (Get-Command gittuf -ErrorAction SilentlyContinue)) {
    Write-Error 'gittuf is not installed or not on PATH. See https://github.com/gittuf/gittuf for installation instructions.'
    exit 1
}

gittuf verify-ref master

if ($LASTEXITCODE -eq 0) {
    Write-Output 'Repository satisfies policy.'
    exit 0
} else {
    Write-Output 'Repository doesnt satisfy poilicy'
    exit 1
}
