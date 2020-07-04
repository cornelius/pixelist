FROM ruby:2.6

WORKDIR /usr/src/pixelist

COPY Gemfile ./
RUN bundle install

COPY . .

CMD ["bin/pixelist", "-p", "examples/crystal.pixels", "work", "crystal", "--show"]
