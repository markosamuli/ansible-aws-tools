aws-tools
=========

[![Build Status](https://travis-ci.org/markosamuli/ansible-aws-tools.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-aws-tools)
[![GitHub release](https://img.shields.io/github/release/markosamuli/ansible-aws-tools.svg)](https://github.com/markosamuli/ansible-aws-tools/releases)
[![License](https://img.shields.io/github/license/markosamuli/ansible-aws-tools.svg)](https://github.com/markosamuli/ansible-aws-tools/blob/master/LICENSE)

Install AWS tools on Ubuntu and OS X:

- [aws-cli](https://github.com/aws/aws-cli)
- [aws-shell](https://github.com/awslabs/aws-shell)
- [aws-vault](https://github.com/99designs/aws-vault)
- [cli53](https://github.com/barnybug/cli53)

Linux packages are installed by default under /opt/aws-tools and binaries symlinked to /usr/local/bin.

OS X packages are installed with Homebrew.

Used in [markosamuli/machine](https://github.com/markosamuli/machine) playbook for setting my workstations.

License
-------

[MIT](LICENSE)

Author Information
------------------

- [@markosamuli](https://github.com/markosamuli)
