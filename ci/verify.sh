#!/usr/bin/env bash
set -uo pipefail

REQUIRED_GITTUF_VERSION='0.17'

ignore_gittuf_version=0

usage() {
    cat >&2 <<USAGE
Usage: $(basename "$0") [--ignore-gittuf-version]

Options:
  --ignore-gittuf-version  Skip the check that gittuf is version ${REQUIRED_GITTUF_VERSION}.
  -h, --help               Show this message.
USAGE
}

while [ $# -gt 0 ]; do
    case "$1" in
        --ignore-gittuf-version)
            ignore_gittuf_version=1
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown argument: $1" >&2
            usage
            exit 1
            ;;
    esac
    shift
done

if ! command -v gittuf >/dev/null 2>&1; then
    echo 'gittuf is not installed or not on PATH. See https://github.com/gittuf/gittuf for installation instructions.' >&2
    exit 1
fi

if [ "$ignore_gittuf_version" -eq 0 ]; then
    # 'gittuf version' prints e.g. 'gittuf version 0.17.0'
    gittuf_version=$(gittuf version 2>/dev/null | head -n 1 | awk '{print $3}')
    case "$gittuf_version" in
        "$REQUIRED_GITTUF_VERSION"|"$REQUIRED_GITTUF_VERSION".*)
            ;;
        *)
            echo "gittuf version ${REQUIRED_GITTUF_VERSION} is required, but found '${gittuf_version:-unknown}'." >&2
            echo 'Pass --ignore-gittuf-version to skip this check.' >&2
            exit 1
            ;;
    esac
fi

if gittuf verify-ref master; then
    echo 'Repository satisfies policy'
    exit 0
else
    echo 'Repository doesnt satisfy policy'
    exit 1
fi
