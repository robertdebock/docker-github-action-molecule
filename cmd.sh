#!/bin/sh -x

# A function to retry an action a few times until succesful.
retry() {
  counter=0
  until "$@" ; do
    exit=$?
    counter=$(($counter + 1))
    if [ $counter -ge ${max_failures:-3} ] ; then
      return $exit
    fi
  done
  return 0
}

# Go into the repository or assume it's here. (`.`)
cd ${GITHUB_REPOSITORY:-.}

# Download the collections for the `verify.yml` playbook.
if [ -f requirements.yml ] ; then
  ansible-galaxy install -r requirements.yml
fi

# Test the role.
if [ -f tox.ini -a ${command:-test} = test ] ; then
  # If `tox.ini` exists, run tox.
  # (Tox will run molecule with a specified Ansible version.)
  retry tox ${options}
else
  # No `tox.ini`?, just run molecule.
  PY_COLORS=1 ANSIBLE_FORCE_COLOR=1 retry molecule ${command:-test} --scenario-name ${scenario:-default}
fi
