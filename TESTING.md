# Testing

To test the container before publication, run these steps.

1. `docker_hash=${docker build . -q}` (Save the hash reference to the built image.)
2. Go to a role-directory, like `ansible-role-example`.
3. `docker run --privileged --volume $(pwd):/github/workspace:z --volume /var/run/docker.sock:/var/run/docker.sock:z --tty --interactive ${docker_hash} /bin/bash
4. Both `molecule test` and `tox` should work.
