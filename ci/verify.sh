#!/usr/bin/env bash
set -uo pipefail

if gittuf verify-ref master; then
    echo 'Repository satisfies policy'
    exit 0
else
    echo 'Repository doesnt satisfy policy'
    exit 1
fi
