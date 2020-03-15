#!/usr/bin/env bash

set -Eeuo pipefail

cli() { local command=${1-""}; local remainingArgs="${@:2}"
    if [[ $command == "" ]]; then
        echo "Please enter a command"
        exit 1
    else
        $command "${@:2}"
    fi
}

start() {
    echo "Download idris for MacOSX via https://github.com/idris-lang/Idris-dev/wiki/Idris-on-Mac-OS-X"
    idris src/qc.idr -o dist/qc
    dist/qc
}

cli "$@"