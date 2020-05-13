FROM fedora:31

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

RUN pip install tox docker ansible-lint "molecule>=3,<4"

CMD cd ${GITHUB_REPOSITORY} ; retry() { a=1 ; echo "Attempt ${a}" ; until $@ ; do if [ $a -ge 5 ] ; then return 1 ; else a=$(($a+1)) ; echo "Attempt ${a}" ; fi; done; } ; if [ -f tox.ini ] ; then retry tox ${options} ; else retry PY_COLORS=1 ANSIBLE_FORCE_COLOR=1 molecule test ; fi
