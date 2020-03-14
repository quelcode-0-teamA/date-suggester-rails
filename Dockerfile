FROM ruby:2.6.5-alpine3.11

ENV APP_ROOT=/date_suggester \
    RUNTIME_PACKAGES="linux-headers tzdata postgresql-dev postgresql" \
    DEV_PACKAGES="build-base libxml2-dev libc-dev curl-dev make gcc g++" \
    LANG=C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

WORKDIR $APP_ROOT

COPY Gemfile Gemfile.lock $APP_ROOT/

RUN apk update && \
    apk add --update --no-cache  $RUNTIME_PACKAGES && \
    apk add --update --virtual build-dependencies --no-cache $DEV_PACKAGES && \
    gem install --no-document bundler:2.1.4 && \
    bundle install && \
    rm -rf /usr/local/bundle/cache/* /usr/local/share/.cache/* /var/cache/* /tmp/* && \
    apk del build-dependencies

COPY . /$APP_ROOT

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

RUN chmod +x $APP_ROOT/bin/start.sh
CMD ["bin/start.sh"]
