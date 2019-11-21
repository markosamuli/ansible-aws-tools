#!/usr/bin/env bash

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=tests/utils.sh
source "${TESTS_DIR}/utils.sh"

failed() {
    error "FAILED: $*"
    exit 1
}

test_install() {
    local ansible_vars=()

    # Remove old installation
    ansible_vars+=('"aws_tools_remove_old_install":true')

    # Remove local installation
    ansible_vars+=('"aws_tools_remove_local_install":true')

    # Check for existing asdf installs
    ansible_vars+=('"aws_tools_check_asdf_installs":true')

    # Initialise PATH in shell rc files
    ansible_vars+=('"aws_tools_init_shell":true')

    # Run playbook and idempotence tests
    run_tests "${ansible_vars[@]}" || failed "playbook run failed"

    # Check binaries have been installed
    check_aws_tools_path || failed "aws-tools directory not found"
    check_awscli || failed "AWS CLI not found"
    check_aws_shell || failed "aws-shell not found"
    check_aws_vault || failed "aws-vault not found"
    check_cli53 || failed "cli53 not found"
    check_aws_tools_update || failed "aws-tools-update script not found"

    echo "PASS"
}

cd "${PROJECT_ROOT}"

set -e

# Install
test_install
