FROM fedora:31

WORKDIR /github/workspace

# These dependecies are required to install pip packages.
RUN dnf install -y python3-pip gcc python3-devel ; \
    dnf clean all

# These dependencies are required to run the CMD.
RUN dnf install -y git-core ;\
    dnf clean all

RUN pip install molecule[docker] tox

CMD cd ${GITHUB_REPOSITORY} ; a=1 ; until [ $a -gt 5 ] ; do if [ -f tox.ini ] ; then tox ${options} && break ; else molecule test && break ; fi ; a=$((a + 1)) ; done

