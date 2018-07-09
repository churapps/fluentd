FROM fluent/fluentd:latest

EXPOSE 24224 5140

RUN apk add sudo \
    && cp /etc/sudoers /etc/sudoers.orig \
    && echo 'fluent ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && echo 'Defaults:fluent !requiretty' >> /etc/sudoers

RUN gem install fluent-plugin-cloudwatch-logs \
    && gem install fluent-plugin-forest