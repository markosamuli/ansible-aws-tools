# Changelog

## [Unreleased]

### Changed

* Install packages under `~/.aws-tools` on Linux.
* Use virtualenv for installing `awscli` and `aws-shell` packages on Linux.
* Added `aws-tools-update` script for updating packages in the virtualenv.

## [2.0.0]

### Changed

* Update cli53 to v0.8.15.
* Update aws-vault to v4.6.2.
* Install packages under `~/.local` on Linux.
* The previous Linux role installed packages under `/opt/aws-tools` and created
symbolic links to `/usr/local/bin`. These will be removed automatically.

## [1.0.1] - 2019-01-13

### Fixed

* Do not check cli53 and aws-vault versions after installing.

## [1.0.0] - 2019-01-13

Initial release with aws-vault v4.4.1 and cli53 v0.8.12.

[Unreleased]: https://github.com/markosamuli/ansible-aws-tools/commits/develop
[2.0.0]: https://github.com/markosamuli/ansible-aws-tools/releases/tag/v2.0.0
[1.0.1]: https://github.com/markosamuli/ansible-aws-tools/releases/tag/v1.0.1
[1.0.0]: https://github.com/markosamuli/ansible-aws-tools/releases/tag/v1.0.0
