FROM ruby:2.6

WORKDIR /usr/src/pixelist

COPY Gemfile ./
RUN bundle install

COPY . .

CMD ["bin/pixelist", "-p", "examples/life.pixels", "work", "life", "--show"]
