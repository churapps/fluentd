# fluent/fluentd:v1.11.5-1.0
FROM fluent/fluentd:v1.11.5-1.0

# usage root user
USER root

# port 24224 -> 5140
EXPOSE 24224 5140

# sudo package install & sudoers settings
RUN apk add sudo \
    && cp /etc/sudoers /etc/sudoers.orig \
    && echo 'fluent ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && echo 'Defaults:fluent !requiretty' >> /etc/sudoers

# gem installing some  packages
RUN apk add --no-cache --virtual .build-deps \
    build-base \
    ruby-dev && \
    gem install fluent-plugin-forest --no-document && \
    gem install fluent-plugin-cloudwatch-logs --no-document && \
    apk del .build-deps

# change user
USER fluent

