# Common tools for AWS

[![GitHub release](https://img.shields.io/github/release/markosamuli/ansible-aws-tools.svg)](https://github.com/markosamuli/ansible-aws-tools/releases)
[![License](https://img.shields.io/github/license/markosamuli/ansible-aws-tools.svg)](https://github.com/markosamuli/ansible-aws-tools/blob/master/LICENSE)

| Branch  | Status |
|---------|--------|
| master  | [![Build Status](https://travis-ci.org/markosamuli/ansible-aws-tools.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-aws-tools)
| develop | [![Build Status](https://travis-ci.org/markosamuli/ansible-aws-tools.svg?branch=develop)](https://travis-ci.org/markosamuli/ansible-aws-tools)

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

Packages and binaries on Linux are installed by under `~/.aws-tools` directory.

If you want to customise this path, update `aws_tools_dir` variable:

```yaml
# Path to user home directory
aws_tools_home: "{{ ansible_env.HOME }}"

# Path to install tools into
aws_tools_dir: "{{ aws_tools_home }}/.aws-tools"
```

The `awscli` and `aws-shell` Python packages will be installed in `virtualenv`
created in `~/.aws-tools/venv`.

### Shell init

The `~/.aws-tools/bin` path will be added to `PATH` in `.bashrc` and `.zshrc` if
it doesn't already exist in these files.

To disable shell file modifications, disable `aws_tools_init_shell` option:

```yaml
aws_tools_init_shell: false
```

### Cleaning up previous installations

Previous installation in `/opt/aws-tools` and symbolic links created in
`/usr/local/bin` will not be removed automatically, but you can remove these old
installs by enabling `aws_tools_remove_old_install` option:

```yaml
aws_tools_remove_old_install: true
```

If you have [`awscli`][awscli package] or [`aws-shell`][aws-shell package]
packages installed in `~/.local`, you can remove these by enabling
`aws_tools_remove_local_install` option:

```yaml
aws_tools_remove_local_install: true
```

## macOS

Packages and binaries on macOS are installed with Homebrew.

## asdf

If you have installed `aws-vault` using [asdf-vm], this role will not install
another local version.

To disable asdf install checks, update Ansible role configuration:

```yaml
aws_tools_check_asdf_installs: false
```

[asdf-vm]: https://asdf-vm.com

## Install Git hooks

Install `pre-commit`, `pre-push` and `commit-msg` Git hooks:

```bash
make install-git-hooks
```

## Update release

Update `aws-vault` and `cli53` release versions:

```bash
make update
```

## Coding style

Install pre-commit hooks and validate coding style:

```bash
make lint
```

## Run tests

Run tests in Ubuntu and Debian using Docker:

```bash
make test
```

## License

[MIT](LICENSE)

## Author Information

- [@markosamuli](https://github.com/markosamuli)
