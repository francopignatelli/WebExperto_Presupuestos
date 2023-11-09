FROM ruby:3.2.2

ENV BUNDLER_VERSION=2.4.21

ENV APP_PATH /app
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

#RUN apt-get install vim curl bash

RUN gem install bundler -v 2.4.21

RUN apt-get update && apt-get install -u nodejs

#COPY package.json ./

COPY Gemfile* ./

RUN bundle config set --local path 'vendor/bundle' && bundle install --jobs=20 --retry=4

RUN cp Gemfile.lock /tmp

COPY . .

RUN chmod +x build/**/*.sh

CMD ["sh"]