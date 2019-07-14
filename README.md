# Common tools for AWS

[![Build Status](https://travis-ci.org/markosamuli/ansible-aws-tools.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-aws-tools)
[![GitHub release](https://img.shields.io/github/release/markosamuli/ansible-aws-tools.svg)](https://github.com/markosamuli/ansible-aws-tools/releases)
[![License](https://img.shields.io/github/license/markosamuli/ansible-aws-tools.svg)](https://github.com/markosamuli/ansible-aws-tools/blob/master/LICENSE)

This Ansible role installs the following tools on Ubuntu and macOS.

| Tool | Ubuntu source | macOS source |
|------|---------------|--------------|
| [aws-cli] | [awscli package] on PyPI | [awscli formula] on Homebrew |
| [aws-shell] | [aws-shell package] on PyPI | [aws-shell formula] on Homebrew |
| [aws-vault] | [aws-vault release] on GitHub | [aws-vault cask] on Homebrew |
| [cli53] | [cli53 release] on GitHub | [cli53 formula] on Homebrew |

[aws-cli]: https://github.com/aws/aws-cli
[aws-shell]: https://github.com/awslabs/aws-shell
[aws-vault]: https://github.com/99designs/aws-vault
[cli53]: https://github.com/barnybug/cli53
[awscli package]: https://pypi.org/project/awscli/
[aws-shell package]: https://pypi.org/project/awscli/
[aws-vault release]: https://github.com/99designs/aws-vault/releases
[cli53 release]: https://github.com/barnybug/cli53/releases
[awscli formula]: https://formulae.brew.sh/formula/awscli
[aws-shell formula]: https://formulae.brew.sh/formula/aws-shell
[aws-vault cask]: https://formulae.brew.sh/cask/aws-vault
[cli53 formula]: https://formulae.brew.sh/formula/cli53
[awscli formula]: https://formulae.brew.sh/formula/awscli

## Linux

Packages and binaries on Linux are installed by under `~/.local` directory.

The `~/.local/bin` path will be added to `PATH` in `.bashrc` and `.zshrc` if
it doesn't already exist in these files.

Any previous installation in `/opt/aws-tools` and symbolic links created in
`/usr/local/bin` will be removed. To disable this, update your Ansible role
configuration:

```yaml
aws_tools_remove_old_install: false
```

## macOS

Packages and binaries on macOS are installed with Homebrew.

## asdf

If you have installed `aws-vault` using [asdf-vm], this role will not install
another version.

To disable asdf install checks, update Ansible role configuration:

```yaml
aws_tools_check_asdf_installs: false
```

[asdf-vm]: https://asdf-vm.com

## License

[MIT](LICENSE)

## Author Information

- [@markosamuli](https://github.com/markosamuli)
