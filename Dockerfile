FROM python:3-alpine
LABEL maintainer="Wisit Tipcheun <MasterTos@yahoo.com>"
ENV PYTHONUNBUFFERED 1

WORKDIR /code

ENV DJANGO_VERSION=2.1.5
RUN pip install django==$DJANGO_VERSION \
    && find /usr/local \
        \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
                | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                | sort -u \
                | xargs -r apk info --installed \
                | sort -u \
    )" \
    && apk add --no-cache --virtual .rundeps $runDeps
