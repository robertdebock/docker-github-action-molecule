#!/bin/sh

echo "ACTION: Welcome to the molecule action."

# A function to retry an action a few times until succesful.
retry() {
  counter=0
  until "$@" ; do
    exit=$?
    counter=$(($counter + 1))
    echo "ACTION: retry attempt ${counter}."
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
  echo "ACTION: Installing requirements found in requirements.yml."
  ansible-galaxy install -r requirements.yml
else
  echo "ACTION: No requirements.yml found, skipping install."
fi

# Test the role.
if [ -f tox.ini -a ${command:-test} = test ] ; then
  # If `tox.ini` exists, run tox.
  # (Tox will run molecule with a specified Ansible version.)
  echo "ACTION: running (retry) tox."
  retry tox ${options}
else
  # No `tox.ini`?, just run molecule.
  echo "ACTION: running (retry) molecule."
  PY_COLORS=1 ANSIBLE_FORCE_COLOR=1 retry molecule ${command:-test} --scenario-name ${scenario:-default}
fi

echo "ACTION: Thanks for using this action."
