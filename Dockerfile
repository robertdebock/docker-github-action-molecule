FROM fedora:31

WORKDIR /github/workspace

RUN dnf install -y python3-pip gcc python3-devel git ; \
    dnf clean all

RUN pip install molecule[docker] tox

CMD cd ${GITHUB_REPOSITORY} ; a=1 ; until [ $a -gt 5 ] ; do if [ -f tox.ini ] ; then tox ${options} && break ; else molecule test && break ; fi ; a=$((a + 1)) ; done

