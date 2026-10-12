#!/usr/bin/env bash
set -uo pipefail

if ! command -v gittuf >/dev/null 2>&1; then
    echo 'gittuf is not installed or not on PATH. See https://github.com/gittuf/gittuf for installation instructions.' >&2
    exit 1
fi

if gittuf verify-ref master; then
    echo 'Repository satisfies policy'
    exit 0
else
    echo 'Repository doesnt satisfy policy'
    exit 1
fi
