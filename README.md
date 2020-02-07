# docker-github-action-molecule

A container that is used for [GitHub actions molecule](https://github.com/marketplace/actions/molecule-action).

This container contains:
- molecule
- docker

The default behaviour is to:
- See if `tox.ini` exists -> Run `tox`
- Otherwise -> Run `molecule test`
