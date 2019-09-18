#!/usr/bin/env bash

set -euo pipefail

[[ -z "${DEBUG:-""}" ]] || set -x

# shellcheck source=test_helpers.bash
. lib/test_helpers.bash
# shellcheck source=evaluator.bash
. lib/evaluator.bash

T_evaluating_a_number_is_a_no_op() {
    local ast
    ast="$(setup_tmpfile)"
    echo "32" > "${ast}"

    evaluate "${ast}"

    read -r result <"${ast}"
    cleanup_tmpfile "${ast}"
    if [[ $result != "32" ]] ; then
	$T_fail "expected ${result} to equal 32"
	return
    fi
}

T_evaluating_a_simple_addition_leaves_the_result() {
    local ast
    ast="$(setup_tmpfile)"
    rm "${ast}"
    cp -r "fixtures/TwelvePlusThree" "${ast}"

    evaluate "${ast}"

    read -r result <"${ast}"
    cleanup_tmpfile "${ast}"
    if [[ $result != "15" ]] ; then
	$T_fail "expected ${result} to equal 15"
	return
    fi
}

T_evaluating_a_simple_subtraction_leaves_the_result() {
    local ast
    ast="$(setup_tmpfile)"
    rm "${ast}"
    cp -r "fixtures/TwelveMinusThree" "${ast}"

    evaluate "${ast}"

    read -r result <"${ast}"
    cleanup_tmpfile "${ast}"
    if [[ $result != "9" ]] ; then
	$T_fail "expected ${result} to equal 9"
	return
    fi
}

_evaluating_a_simple_multiplication_leaves_the_result() {
    local ast
    ast="$(setup_tmpfile)"
    rm "${ast}"
    cp -r "fixtures/TwelveTimesThree" "${ast}"

    evaluate "${ast}"

    read -r result <"${ast}"
    cleanup_tmpfile "${ast}"
    if [[ $result != "36" ]] ; then
	$T_fail "expected ${result} to equal 36"
	return
    fi
}
