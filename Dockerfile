FROM python:3.7-alpine

WORKDIR /github/workspace

RUN apk add --update --no-cache python py-pip docker git && \
    apk add --update --no-cache --virtual builddeps gcc python-dev musl-dev libffi-dev openssl-dev make && \
    pip install molecule[docker] tox && \
    apk del builddeps

CMD cd ${GITHUB_REPOSITORY} ; test -f tox.ini && tox ${options} || molecule test
