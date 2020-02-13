FROM fedora:31

WORKDIR /github/workspace

# These dependecies are required to install pip packages.
RUN dnf install -y gcc python3-devel python3-pip; \
    dnf clean all

# These dependencies are required to run the CMD.
RUN dnf install -y docker git-core ;\
    dnf clean all

RUN pip install molecule[docker] tox

CMD retry() { a=1 ; echo "Attempt ${a}" ; until $@ ; do if [ $a -ge 5 ] ; then return 1 ; else a=$(($a+1)) ; echo "Attempt ${a}" ; fi; done; } ; if [ -f tox.ini ] ; then retry tox ${options} ; else retry molecule test ; fi
