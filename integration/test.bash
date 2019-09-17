#!/usr/bin/env bash

set -euo pipefail

[[ -z "${DEBUG:-""}" ]] || set -x

T_calc_evaluates_an_expression() {
    local expr="8 + 3\nq"
    local result
    result=$(echo -e "$expr" | ./calc)
    [[ "$result" =~ "11" ]]
}

T_calc_evaluates_multiple_expressions() {
    EXPR="8 + 3\n12 - 5\nq"
    RESULT=$(echo -e "$EXPR" | ./calc)
    if [[ ! $RESULT =~ "11" ]] ; then
	  # shellcheck disable=SC2154
	$T_fail "first expression didn't evaluate"
    fi
    [[ "$RESULT" =~ "7" ]]
}
