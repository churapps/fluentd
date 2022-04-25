# fluent/fluentd:
FROM fluent/fluentd:v1.14-1

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
RUN apk add --no-cache --update --virtual .build-deps \
    sudo build-base ruby-dev \
    && sudo gem install fluent-plugin-forest --no-document \
    && sudo gem install fluent-plugin-cloudwatch-logs --no-document \
    && sudo gem sources --clear-all \
    && apk del .build-deps \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/

# change user
USER fluent

