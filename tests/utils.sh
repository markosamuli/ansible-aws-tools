#!/usr/bin/env bash

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT=$(dirname "$TESTS_DIR")
export PROJECT_ROOT

# Paths in which Ansible will search for Roles
ANSIBLE_ROLES_PATH=$(dirname "$PROJECT_ROOT")
export ANSIBLE_ROLES_PATH

# Print error into STDERR
error() {
    echo "$@" 1>&2
}

syntax_check() {
    echo "*** Check syntax"
    if ansible-playbook tests/test.yml -i tests/inventory --syntax-check; then
        echo "Syntax check: pass"
    else
        echo "Syntax check: fail"
        return 1
    fi
}

run_tests() {
    local ansible_vars=("$@")
    local extra_vars
    extra_vars=$(printf ",%s" "${ansible_vars[@]}")
    extra_vars="{${extra_vars:1}}"

    echo "*** Run Ansible playbook"
    if run_playbook "${extra_vars}"; then
        echo "Playbook run: pass"
    else
        echo "Playbook run: fail"
        return 1
    fi

    echo "*** Idempotence test"
    if run_playbook "${extra_vars}" | grep -q 'changed=0.*failed=0'; then
        echo "Idempotence test: pass"
    else
        echo "Idempotence test: fail"
        return 1
    fi
}

run_playbook() {
    local extra_vars="$1"
    ansible-playbook tests/test.yml -i tests/inventory --connection=local \
        -e "${extra_vars}" -v
}


check_aws_tools_path() {
    local aws_tools_path="$HOME/.aws-tools/bin"
    if [ ! -d "${aws_tools_path}" ]; then
        error "${aws_tools_path} doesn't exist"
        return 1
    fi
}

aws_tools_binary_exists() {
    local binary="$1"
    local aws_tools_path="$HOME/.aws-tools/bin"
    if [ ! -e "${aws_tools_path}/${binary}" ]; then
        error "[$binary] ${aws_tools_path}/${binary} doesn't exist"
        return 1
    fi
}

check_awscli() {
    local binary="aws"
    aws_tools_binary_exists "${binary}" || return 1
    bash_command_exists "${binary}" || return 1
    zsh_command_exists "${binary}" || return 1
    bash_command_version "${binary}" || return 1
}

check_aws_shell() {
    local binary="aws-shell"
    aws_tools_binary_exists "${binary}" || return 1
    bash_command_exists "${binary}" || return 1
    zsh_command_exists "${binary}" || return 1
}

check_aws_vault() {
    local binary="aws-vault"
    aws_tools_binary_exists "${binary}" || return 1
    bash_command_exists "${binary}" || return 1
    zsh_command_exists "${binary}" || return 1
    bash_command_version "${binary}" || return 1
}

check_cli53() {
    local binary="cli53"
    aws_tools_binary_exists "${binary}" || return 1
    bash_command_exists "${binary}" || return 1
    zsh_command_exists "${binary}" || return 1
    bash_command_version "${binary}" || return 1
}

check_aws_tools_update() {
    local binary="aws-tools-update"
    aws_tools_binary_exists "${binary}" || return 1
    bash_command_exists "${binary}" || return 1
    zsh_command_exists "${binary}" || return 1
}

bash_command_exists() {
    local binary="$1"
    local binary_path
    binary_path=$(bash -i -c "command -v ${binary} 2>/dev/null")
    if [ -z "${binary_path}" ]; then
        error "[bash : $binary] command not found"
        return 1
    fi
    echo "[bash : $binary] ${binary_path}"
    return 0
}

zsh_command_exists() {
    local binary="$1"
    local binary_path
    binary_path=$(zsh -i -c "command -v ${binary} 2>/dev/null")
    if [ -z "${binary_path}" ]; then
        error "[zsh : $binary] command not found"
        return 1
    fi
    echo "[zsh : $binary] ${binary_path}"
    return 0
}

bash_command_version() {
    local binary="$1"
    local binary_version
    binary_version=$(bash -i -c "${binary} --version 2>&1")
    if [ -z "${binary_version}" ]; then
        error "[bash : $binary] failed to get version"
        return 1
    fi
    echo "[bash : $binary] ${binary_version}"
    return 0
}

zsh_command_version() {
    local binary="$1"
    binary_version=$(zsh -i -c "${binary} --version 2>&1")
    if [ -z "${binary_version}" ]; then
        error "[zsh : $binary] failed to get version"
        return 1
    fi
    echo "[zsh : $binary] ${binary_version}"
}
