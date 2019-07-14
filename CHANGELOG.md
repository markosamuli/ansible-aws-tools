# Changelog

## [Unreleased]

### Changed

* Install packages under `~/.local` on Linux.
* The previous Linux role installed packages under `/opt/aws-tools` and created
symbolic links to `/usr/local/bin`. These will be removed automatically.

## [1.0.1] - 2019-01-13

### Fixed

* Do not check cli53 and aws-vault versions after installing.

## [1.0.0] - 2019-01-13

Initial release with aws-vault v4.4.1 and cli53 v0.8.12.

[Unreleased]: https://github.com/markosamuli/ansible-aws-tools/commits/develop
[1.0.1]: https://github.com/markosamuli/ansible-aws-tools/releases/tag/v1.0.1
[1.0.0]: https://github.com/markosamuli/ansible-aws-tools/releases/tag/v1.0.0
