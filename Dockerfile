FROM python:3-alpine
LABEL maintainer="Wisit Tipcheun <MasterTos@yahoo.com>"
ENV PYTHONUNBUFFERED 1

WORKDIR /code
ONBUILD COPY --from=mastertos/django:base /install /usr/local
