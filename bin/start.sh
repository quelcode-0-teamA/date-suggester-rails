#!/bin/sh

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed_fu FIXTURE_PATH=./db/fixtures/development
bundle exec rails s -p 3000 -b '0.0.0.0'