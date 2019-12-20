FROM python:3.7-alpine

WORKDIR /github/workspace

RUN apk add --update --no-cache python py-pip docker && \
    apk add --update --no-cache --virtual build_dependencies gcc python-dev musl-dev libffi-dev openssl-dev make && \
    pip install molecule[docker] tox && \
    apk del build_dependencies

CMD cd ${GITHUB_REPOSITORY} ; test -f tox.ini && tox || molecule test
