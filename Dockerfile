FROM python:3.7-alpine

WORKDIR /github/workspace

RUN apk add --update --no-cache python py-pip docker git gcc musl-dev libffi-dev make openssl-dev python-dev && \
    pip install molecule[docker] tox

CMD cd ${GITHUB_REPOSITORY} ; \
    if [ -f tox.ini ] ; then tox ${options} ; else molecule test ; fi
