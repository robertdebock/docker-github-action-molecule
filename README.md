# docker-github-action-molecule

A container that is used for [GitHub actions molecule](https://github.com/marketplace/actions/molecule-action).

[![github-action-molecule build status](https://img.shields.io/docker/cloud/build/robertdebock/github-action-molecule.svg)](https://hub.docker.com/repository/docker/robertdebock/github-action-molecule)

This container contains:
- [docker](https://www.docker.com/) - Used by molecule to start instances using the `docker` driver.
- [git](https://git-scm.com/) - Used to pull data from a repository.
- [molecule](https://molecule.readthedocs.io/en/latest/) version 3.x.x - Used to orchestrate the tests
- [tox](https://tox.readthedocs.io/en/latest/) - Used to test multiple version of ansible if `tox.ini` exists.

The default behaviour is to:
- See if `tox.ini` exists -> Run `tox`
- Otherwise -> Run `molecule test`
- Retry either (`tox` or `molecule`) 3 times.
- Run `test` if `command` is not set.
- Test the `default` scenario if `scenario` in not set.
