FROM fedora:32

LABEL maintainer="Robert de Bock <robert@meinit.nl>"

WORKDIR /github/workspace

RUN dnf install -y docker \
                   gcc \
                   git-core \
                   python3-devel \
                   python3-pip \
                   python3-libselinux \
                   python3-jmespath.noarch ; \
    dnf clean all

RUN pip install tox docker ansible-lint "molecule>=3,<4" testinfra

CMD cd ${GITHUB_REPOSITORY} ; if [ -f tox.ini -a ${command:-test} = test ] ; then n=0 ; until [ "$n" = 3 ] ; do tox ${options} && break ; n=$((n+1)) ; done ; else n=0 ; until [ "$n" = 3 ] ; do PY_COLORS=1 ANSIBLE_FORCE_COLOR=1 molecule ${command:-test} && break ; n=$((n+1)) ; done ; fi
