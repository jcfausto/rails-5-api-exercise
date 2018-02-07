# Rails 5 API Exercise

This API contains the basics:

- [X] Run on Docker
- [X] REST implementation
- [X] Serialization
- [WIP] Authentication (email and password)
- [WIP] Authorization with JWT
- [X] Pagination
- [NEXT] Custom error handling
- [NEXT] Some custom concerns and helpers
- [X] Live on Heroku (Entrypoint: https://serene-inlet-37938.herokuapp.com)

## How to run

### On Docker
```
$ docker-compose build
$ docker-compose run api rspec
$ docker-compose up
```

### On Heroku
```
$ docker-compose build
$ docker run -itP r5todoapi "rspec"
$ heroku container:push web
$ heroku run rake db:migrate
$ heroku open
```

### Stand alone
```
$ bundle install
$ rake db:create
$ rake db:migrate
$ bundle exec rspec
```
