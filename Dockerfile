FROM fedora:35

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2022-01-21"

WORKDIR /github/workspace

RUN dnf install -y docker \
                   gcc \
                   git-core \
                   python3-devel \
                   python3-pip \
                   python3-libselinux \
                   python3-jmespath ; \
    dnf clean all ;

RUN pip install ansible-core \
                molecule[docker] \
                tox \
                docker \
                testinfra \
                ansible-later \
                ansible-lint

RUN ansible-galaxy collection install community.docker
RUN ansible-galaxy collection install community.general

ADD cmd.sh /cmd.sh

CMD sh /cmd.sh
