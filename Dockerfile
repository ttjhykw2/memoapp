FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y postgresql-client

RUN apt-get install -y gnupg
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

RUN mkdir /memoapp
WORKDIR /memoapp
COPY Gemfile /memoapp/Gemfile
COPY Gemfile.lock /memoapp/Gemfile.lock
RUN bundle install
COPY . /memoapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

