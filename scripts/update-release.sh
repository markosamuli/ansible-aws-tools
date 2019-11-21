#!/usr/bin/env bash

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT=$(dirname "$SCRIPTS_DIR")

# shellcheck source=scripts/utils.sh
source "${SCRIPTS_DIR}/utils.sh"

# Update cli53 version
update_cli53_version() {
    local version=$1
    local binary="cli53-linux-amd64"
    local vars_file="vars/os/Linux_x86_64.yml"
    local checksum
    checksum=$(get_cli53_checksum "${version}" "${binary}")
    [ -z "${checksum}" ] && exit 1
    update_variable_file "${vars_file}" cli53_version "${version}"
    update_variable_file "${vars_file}" cli53_binary "${binary}"
    update_variable_file "${vars_file}" cli53_checksum "sha256:${checksum}"
}

# Get cli53 binary checksum
get_cli53_checksum() {
    local release=$1
    local binary=$2
    local url="https://github.com/barnybug/cli53/releases/download/${release}"
    url="${url}/cli53_${release}_checksums.txt"
    curl -L --silent "${url}" |
        grep "${binary}" |
        awk '{ print $1 }'
}

# Update aws-vault version
update_aws_vault_version() {
    local version=$1
    local binary="aws-vault-linux-amd64"
    local vars_file="vars/os/Linux_x86_64.yml"
    local checksum
    checksum=$(get_aws_vault_checksum "v${version}" "${binary}")
    [ -z "${checksum}" ] && exit 1
    update_variable_file "${vars_file}" aws_vault_version "${version}"
    update_variable_file "${vars_file}" aws_vault_binary "${binary}"
    update_variable_file "${vars_file}" aws_vault_checksum "sha256:${checksum}"
}

# Get aws-vault binary checksum
get_aws_vault_checksum() {
    local release=$1
    local binary=$2
    local url="https://github.com/99designs/aws-vault"
    url="${url}/releases/download/${release}"
    url="${url}/${binary}"
    curl -L --silent "${url}" | sha256sum | awk '{ print $1 }'
}

# Get latest cli53 version
latest_cli53_version() {
    local latest_release
    latest_release=$(get_latest_release barnybug/cli53)
    [ -z "${latest_release}" ] && {
        error "Failed to get latest release from GitHub"
        return 1
    }
    echo "${latest_release}"
}

# Get latest aws-vault version
latest_aws_vault_version() {
    local latest_release
    latest_release=$(get_latest_release 99designs/aws-vault)
    [ -z "${latest_release}" ] && {
        error "Failed to get latest release from GitHub"
        return 1
    }
    echo "${latest_release//v/}"
}

# Update all versions
update_versions() {
    local cli53_version
    cli53_version=$(latest_cli53_version)
    echo "Latest cli53 release is ${cli53_version}"
    update_cli53_version "${cli53_version}"

    local aws_vault_version
    aws_vault_version=$(latest_aws_vault_version)
    echo "Latest aws-vault release is ${aws_vault_version}"
    update_aws_vault_version "${aws_vault_version}"
}

set -e

cd "${PROJECT_ROOT}"

update_versions
