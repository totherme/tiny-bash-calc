#!/usr/bin/env bash

set -euo pipefail

[[ -z "${DEBUG:-""}" ]] || set -x

# shellcheck source=parser.bash
. lib/parser.bash

_parsing_number_writes_a_single_file() {
    tmpdir="$(dirname "$(mktemp -u)")"
    result_file="$(mktemp "${tmpdir}/calc.XXXXXXXXXXXX.tmp")"

    parse "87" "${result_file}"

    read -r result <"${result_file}"
    [[ $result == "87" ]]
}
