#!/bin/bash
set -e
set -x

if [[ $1 = 'dotnet' ]]; then
    set +x
    ./ensure-cert-setup.sh
    exec /usr/bin/dotnet "${@:2}"
fi

set +x
exec "$@"
