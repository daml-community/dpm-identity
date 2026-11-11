#!/usr/bin/env pwsh

$RequiredGittufVersion = '0.17'
$BaseBranch = 'master'

$IgnoreGittufVersion = $false

function Show-Usage {
    Write-Output @"
Usage: verify.ps1 [--ignore-gittuf-version]

Verifies that the current branch can be merged into '$BaseBranch' under the
repository's gittuf policy.

Options:
  --ignore-gittuf-version  Skip the check that gittuf is version $RequiredGittufVersion.
  -h, --help               Show this message.
"@
}

foreach ($arg in $args) {
    switch ($arg) {
        '--ignore-gittuf-version' { $IgnoreGittufVersion = $true }
        '-IgnoreGittufVersion'    { $IgnoreGittufVersion = $true }
        { $_ -in '-h', '--help' } { Show-Usage; exit 0 }
        default {
            Write-Error "Unknown argument: $arg"
            Show-Usage
            exit 1
        }
    }
}

if (-not (Get-Command gittuf -ErrorAction SilentlyContinue)) {
    Write-Error 'gittuf is not installed or not on PATH. See https://github.com/gittuf/gittuf for installation instructions.'
    exit 1
}

if (-not $IgnoreGittufVersion) {
    # 'gittuf version' prints e.g. 'gittuf version 0.17.0'
    $GittufVersion = (@(gittuf version 2>$null)[0] -split '\s+')[2]
    if (-not ($GittufVersion -eq $RequiredGittufVersion -or $GittufVersion -like "$RequiredGittufVersion.*")) {
        if (-not $GittufVersion) { $GittufVersion = 'unknown' }
        Write-Error "gittuf version $RequiredGittufVersion is required, but found '$GittufVersion'. Pass --ignore-gittuf-version to skip this check."
        exit 1
    }
}

$FeatureBranch = git symbolic-ref --quiet --short HEAD
if (-not $FeatureBranch) {
    Write-Error 'Unable to determine the current branch; HEAD is detached. Check out a branch and try again.'
    exit 1
}

Write-Output "Verifying that '$FeatureBranch' can be merged into '$BaseBranch'..."

gittuf verify-mergeable --base-branch $BaseBranch --feature-branch $FeatureBranch

if ($LASTEXITCODE -eq 0) {
    Write-Output 'Repository satisfies policy.'
    exit 0
} else {
    Write-Output 'Repository doesnt satisfy poilicy'
    exit 1
}
