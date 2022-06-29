#!/bin/sh

echo "ACTION: Welcome to the molecule action."

# A function to retry an action a few times until succesful.
retry() {
  counter=0
  until "$@" ; do
    exit=$?
    counter=$((counter + 1))
    echo "ACTION: retry attempt ${counter}."
    if [ "$counter" -ge "${max_failures:-3}" ] ; then
      return $exit
    fi
  done
  return 0
}

# Go into the repository or assume it's here. (`.`)
cd "${GITHUB_REPOSITORY:-.}" || exit

# Test the role.
if [ -f tox.ini ] && [ "${command:-test}" = test ] ; then
  # If `tox.ini` exists, run tox.
  # (Tox will run molecule with a specified Ansible version.)
  echo "ACTION: running (retry) tox."
  retry tox
else
  # No `tox.ini`?, just run molecule.
  echo "ACTION: running (retry) molecule."
  PY_COLORS=1 ANSIBLE_FORCE_COLOR=1 retry molecule "${command:-test}" --scenario-name "${scenario:-default}"
fi || status="failed"


# Finish with the correct failure code.
if [ "${status}" = "failed" ] ; then
  echo "ACTION: Thanks for using this action, good luck troubleshooting."
  exit 1
else
  echo "ACTION: Thanks for using this action."
fi
