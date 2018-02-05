# Rails 5 API Exercise

This API contains the basics:

- [X] Run on Docker
- [X] REST implementation
- [WIP] Authentication (username and password)
- [WIP] Authorization with JWT
- [NEXT] Pagination
- [NEXT] Custom error handling
- [NEXT] Some custom concerns and helpers
- [NEXT] Live on Heroku

## How to run

### On Docker
```
$ docker-compose build
$ docker run -itP r5todoapi "rspec"
$ docker-compose up
```

### Stand alone
```
$ bundle install
$ rake db:create
$ rake db:migrate
$ bundle exec rspec
```
