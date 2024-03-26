# Testing

To test the container before publication, run these steps.

1: `docker_hash=$(docker build . -q)`.
2: Go to a role-directory, like `ansible-role-test`.
3: Try lint:

```shell
cd tests/ansible-role-test
docker run --privileged \
  --volume $(pwd):/github/workspace/robertdebock/$(basename $(pwd)):z \
  --volume /var/run/docker.sock:/var/run/docker.sock:z \
  --tty \
  --interactive \
  --env command="syntax" \
  --env GITHUB_REPOSITORY="robertdebock/$(basename  $(pwd))" \
  --env ANSIBLE_ROLES_PATH="../" \
  ${docker_hash}
cd ../
```

4: Try role:

```shell
cd tests/ansible-role-test
docker run --privileged \
  --volume $(pwd):/github/workspace/robertdebock/$(basename $(pwd)):z \
  --volume /var/run/docker.sock:/var/run/docker.sock:z \
  --tty \
  --interactive \
  --env GITHUB_REPOSITORY="robertdebock/$(basename $(pwd))" \
  --env ANSIBLE_ROLES_PATH="../" \
  ${docker_hash}
cd ../
```
