FROM alpine:latest

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2024-03-26"

WORKDIR /github/workspace

RUN apk add --no-cache docker \
                   gcc \
                   git \
                   python3-dev \
                   py3-jmespath \
                   py3-pip \
                   rsync && \
    rm -rf /var/cache/apk/*

RUN python3 -m venv /opt/venv

ADD requirements.txt /requirements.txt

RUN /opt/venv/bin/python -m pip install --no-cache-dir -r /requirements.txt && \
    /opt/venv/bin/python -m pip cache purge

RUN echo "/bin/sh /opt/venv/bin/activate" > /etc/profile.d/molecule-venv.sh ; \
    echo "export PATH=/opt/venv/bin:$PATH" >> /etc/profile.d/molecule-venv.sh

ADD cmd.sh /cmd.sh
CMD sh /cmd.sh
