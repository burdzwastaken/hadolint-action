#!/usr/bin/env bash

set -euo pipefail

die() {
    echo "$@" >&2
    exit 1
}

ROOT=$(cd "$(dirname "$(dirname "$0")")" && pwd)

cd "$ROOT"

CURRENTVERSION=${1:-}
NEWVERSION=${2:-}

if [[ -z "${CURRENTVERSION}" ]] || [[ -z "${NEWVERSION}" ]]; then
    die "$0 <currentversion> <newversion>"
fi

find "$ROOT" -type f -not -iwholename '*.git*' -exec sed -i -e "s/${CURRENTVERSION}/${NEWVERSION}/g" {} \;
