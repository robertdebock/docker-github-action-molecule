# Testing

To test the container before publication, run these steps.

1. `docker_hash=$(docker build . -q)`.
2. Go to a role-directory, like `ansible-role-example`.
3. `docker run --privileged --volume $(pwd):/github/workspace:z --volume /var/run/docker.sock:/var/run/docker.sock:z --tty --interactive ${docker_hash}`
3. Try lint: `docker run --privileged --volume $(pwd):/github/workspace/robertdebock/ansible-role-example:z --volume /var/run/docker.sock:/var/run/docker.sock:z --tty --interactive --env command="lint" --env GITHUB_REPOSITORY="robertdebock/ansible-role-libvirt" --env ANSIBLE_ROLES_PATH="../" ${docker_hash}`
4. Try role: `docker run --privileged --volume $(pwd):/github/workspace/robertdebock/ansible-role-example:z --volume /var/run/docker.sock:/var/run/docker.sock:z --tty --interactive --env GITHUB_REPOSITORY="robertdebock/ansible-role-libvirt" --env ANSIBLE_ROLES_PATH="../" ${docker_hash}`
