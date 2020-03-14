FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

ENV APP_ROOT /date_suggester
WORKDIR $APP_ROOT

ENV LANG=ja_JP.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
RUN gem install --no-document bundler:2.1.4
COPY Gemfile Gemfile.lock /
RUN bundle install

COPY . /

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
