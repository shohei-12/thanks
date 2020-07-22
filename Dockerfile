FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  nodejs \
  yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir /thanks
WORKDIR /thanks
COPY Gemfile /thanks/Gemfile
COPY Gemfile.lock /thanks/Gemfile.lock
RUN bundle install
COPY . /thanks
