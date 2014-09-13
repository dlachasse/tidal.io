# Tidal.io

- Ruby version: `2.1.1`
- Rails version: `4.1.0`
- Database requirements:
	- Create database for development/test
	- Create database name/host in application.yml
	- Run `rake db:migrate` to instantiate
- Run tests with `rspec`
- To regenerate assets run `rake assets:clobber && rake assets:precompile`

## Running (Locally)

1. Start Postgre
2. `redis-server /usr/local/etc/redis.confredis-server`
3. `sidekiq`
4. `rails s`

## Requests

When making requests against the API, make sure to include the following headers:

```http
Authorization: Token token=[YOUR API KEY]
Accept: application/tidal.v1
```