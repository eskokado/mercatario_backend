FROM ruby:3.4.1
RUN apt-get update && apt-get install -y postgresql-client
WORKDIR /app
COPY Gemfile* .
RUN bundle install
COPY . .
CMD ["rails", "server", "-b", "0.0.0.0"]