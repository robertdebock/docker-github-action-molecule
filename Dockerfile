FROM alpine:latest

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2024-03-26"

WORKDIR /github/workspace

ADD requirements.txt /requirements.txt

RUN apk add --no-cache docker \
      gcc \
      git \
      python3-dev \
      py3-jmespath \
      py3-pip \
      rsync && \
    rm -rf /var/cache/apk/* && \
    python3 -m venv /opt/venv && \
    /opt/venv/bin/python -m pip install --no-cache-dir -r /requirements.txt && \
    /opt/venv/bin/python -m pip cache purge && \
    echo "source /opt/venv/bin/activate" > /root/.profile

ADD cmd.sh /cmd.sh
CMD sh /cmd.sh
