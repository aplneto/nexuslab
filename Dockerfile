FROM ruby:2.7.0

ENV DISABLE_DATABASE_ENVIRONMENT_CHECK=1
ENV RACK_ENV=production
ENV DATABASE_HOST=localhost
ENV DATABASE_NAME=postgres
ENV DATABASE_USER=postgres
ENV DATABASE_PASSWORD=senha
ENV DATABASE_PORT=5432

RUN mkdir /home/Sinatra
ADD . / /home/Sinatra/
WORKDIR /home/Sinatra/

RUN bundle install

EXPOSE 8443

CMD ["/bin/bash", "startup.sh"]