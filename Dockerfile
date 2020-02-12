FROM python:3.7-alpine

WORKDIR /github/workspace

RUN apk add --update --no-cache python py-pip docker git gcc musl-dev libffi-dev make openssl-dev python-dev

RUN pip install molecule[docker] tox

CMD cd ${GITHUB_REPOSITORY} ; a=1 ; until [ $a -gt 5 ] ; do if [ -f tox.ini ] ; then tox ${options} && break ; else molecule test && break ; fi ; a=$((a + 1)) ; done

