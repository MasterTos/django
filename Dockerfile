FROM python:3-alpine as build
LABEL maintainer="Wisit Tipcheun <MasterTos@yahoo.com>"
ENV PYTHONUNBUFFERED 1

WORKDIR /install

ENV DJANGO_VERSION=2.1.2
RUN pip install --install-option="--prefix=/install" --no-cache-dir django==$DJANGO_VERSION
ONBUILD ADD ./requirements.txt /requirements.txt
ONBUILD RUN  apk add --update --no-cache python3-dev postgresql-dev musl-dev build-base linux-header \
    ca-certificates gcc graphviz g++ git libffi-dev jpeg-dev zlib-dev \
    && pip install --install-option="--prefix=/install" --no-cache-dir -r requirements.txt

FROM python:3-alpine
WORKDIR /code
ONBUILD COPY --from=build /install /usr/local
