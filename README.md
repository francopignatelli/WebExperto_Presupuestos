# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Docker

-docker compose build 

-docker compose run --rm web bundle install

docker compose run --rm web bundle exec rake db:create

docker compose run --rm web bundle exec rake db:migrate (no siempre)

docker compose run --rm --service-ports web (Debug) (En vez de up)

#Para entrar a la consola de Rails:
-docker compose run --rm web bundle exec rails c