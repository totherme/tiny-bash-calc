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
    test_fixture_evaluation "fixtures/TwelvePlusThree" 15
}

T_evaluating_a_simple_subtraction_leaves_the_result() {
    test_fixture_evaluation "fixtures/TwelveMinusThree" 9
}

T_evaluating_a_simple_multiplication_leaves_the_result() {
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

test_fixture_evaluation() {
    local ast fixture_path expected_result
    fixture_path="${1:?first argument to test_fixture_evaluation should be a fixture}"
    expected_result="${2:?second argument to test_fixture_evaluation should be our expected result}"
    ast="$(setup_tmpfile)"
    rm "${ast}"
    cp -r "${fixture_path}" "${ast}"

    evaluate "${ast}"

    read -r result <"${ast}"
    cleanup_tmpfile "${ast}"
    if [[ $result != "${expected_result}" ]] ; then
	$T_fail "expected ${result} to equal ${expected_result}"
	return
    fi
}
