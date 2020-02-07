FROM python:3.7-alpine

WORKDIR /github/workspace

RUN apk add --update --no-cache python py-pip docker git gcc linux-headers && \
    apk add --update --no-cache --virtual builddeps python-dev musl-dev libffi-dev openssl-dev make && \
    pip install molecule[docker] tox && \
    apk del builddeps

CMD cd ${GITHUB_REPOSITORY} ; \
    if [ -f tox.ini ] ; then tox ${options} ; else molecule test ; fi
