FROM ruby:2.5.3-alpine as build

# Install gem bundle
ADD Gemfile /app/
ADD Gemfile.lock /app/
WORKDIR /app

# Install required packages
RUN apk add --no-cache build-base nodejs git mysql-dev postgresql-dev tzdata shared-mime-info

# Upgrades bundler versions
RUN gem install bundler

# Install gems
RUN bundle install --jobs 10 --without development test

# Install the application
ADD . /app

# Precompile assets
RUN bundle exec rake assets:precompile RAILS_ENV=production SECRET_KEY_BASE=secret

ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

EXPOSE $PORT

CMD ./bin/app_update && bundle exec rails s -p 3000 -b '0.0.0.0'
