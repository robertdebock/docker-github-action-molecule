FROM python:3.7-alpine

WORKDIR /github/workspace

RUN apk add --update --no-cache python py-pip docker git gcc python-dev musl-dev libffi-dev openssl-dev make && \
    pip install molecule[docker] tox

CMD cd ${GITHUB_REPOSITORY} ; test -f tox.ini && tox || molecule test
