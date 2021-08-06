# this is the automation system Dockerfile.
# it will basically Python, with Behave BDD testing framework module, and requests module for http requests

FROM python:3.8.3-slim
MAINTAINER Benttt <widfgdfg@gmail.com>
COPY requirements.txt /tmp
RUN \
    echo "==> Install common stuff missing from the slim base image..."   && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3-dev              \
        python3-pip         && \

    echo "==> Install useful Python stuff..."   && \
    pip3 --disable-pip-version-check install -r /tmp/requirements.txt
WORKDIR /behave
ENTRYPOINT ["behave"]