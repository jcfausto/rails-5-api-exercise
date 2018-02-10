# Rails 5 API Exercise

This is an API for a Todo application.

This API contains the basics:

- [X] Run on Docker
- [X] REST implementation
- [X] Serialization
- [X] Authorization and Authentication
  - [X] Authentication service (email and password)
  - [X] Authorization service with JWT
  - [X] Sign up and Login endpoints
- [X] Pagination
- [X] Custom error handling
- [X] Custom concerns and helpers
- [NEXT] Delete account
- [X] API versioning
- [X] Live on Heroku (Entrypoint: https://serene-inlet-37938.herokuapp.com)

## API docs available here

[Postman documentation](https://documenter.getpostman.com/view/1104741/collection/RVfsHDmr)

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
