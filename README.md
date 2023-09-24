# docker-github-action-molecule

A container that is used for [GitHub actions molecule](https://github.com/marketplace/actions/test-ansible-roles-with-molecule).

[![github-action-molecule build status](https://img.shields.io/docker/cloud/build/robertdebock/github-action-molecule.svg)](https://hub.docker.com/repository/docker/robertdebock/github-action-molecule)

This container contains:

- [ansible](https://ansible.com/) - Used to run the tests.
- [ansible-lint](https://ansible-lint.readthedocs.io/en/latest/usage.html/) - A command-line tool for linting playbooks, roles and collections aimed towards any Ansible users.
- [docker](https://www.docker.com/) - Used by molecule to start instances using the `docker` driver.
- [molecule](https://molecule.readthedocs.io/en/latest/) - Used to orchestrate the tests. [molecule-plugins](https://github.com/ansible-community/molecule-plugins) are installed too.
- [tox](https://tox.readthedocs.io/en/latest/) - Used to test multiple version of ansible if `tox.ini` exists.
- [testinfra](https://testinfra.readthedocs.io/en/latest/) - Used to test the instances.
- [yamllint](https://yamllint.readthedocs.io/en/stable/) - Used to lint YAML files.
- rsync, required in same cases for Molecule.
- Linux tools like `docker`, `gcc`, `git` (core), `python3-*` and `rsync` are installed too.

The default behaviour is to:

- See if `tox.ini` exists -> Run `tox`
- Otherwise -> Run `molecule test`
- Retry either (`tox` or `molecule`) 3 times.
- Run `test` if `command` is not set.
- Test the `default` scenario if `scenario` in not set.

Read how to [test locally](TESTING.md).

## [Author Information](#author-information)

[robertdebock](https://robertdebock.nl/)

Please consider [sponsoring me](https://github.com/sponsors/robertdebock).
