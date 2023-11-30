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

docker compose build 

#Solo si hay gemas nuevas
docker compose run --rm web bundle install

#Solo si no existe la base de datos
docker compose run --rm web bundle exec rake db:create

#Migra los modelos nuevos o las modificaciones de estos (no siempre)
docker compose run --rm web bundle exec rake db:migrate 

#Enciende la pagina web localhost:3000 (Debug) (En vez de up)
docker compose run --rm --service-ports web 

#Elimina las migraciones hechas una a una, se debe de ejecutar varias veces
docker compose run --rm web bundle exec rake db:rollback

#Para entrar a la consola de Rails:
docker compose run --rm web bundle exec rails c