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

1. Start Postgres
2. `redis-server /usr/local/etc/redis.confredis-server`
3. `sidekiq`
4. `rails s`

## Requests

When making requests against the API, make sure to include the following headers:

```http
Authorization: Token token=[YOUR API KEY]
Accept: application/tidal.v1
```

## Vagrant Setup

As much as I would like this to be automated, it's proving quite difficult. You'll have to run a few commands via vagrant SSH until I figure out how to make this a little less painless.

After running `vagrant up` to provision your machine, you'll need to create the /var/www/ directory and symlink the shared folder so nginx is able to serve up your application.
```bash
cd /vagrant
sudo mkdir /var/www/
sudo ln -s ./* /var/www/
```

Bundler needs to be installed as an executable, and libcurl needs to be installed for curb gem. Once these are on the machine you'll be able to run bundler.
```bash
sudo gem install bundler
sudo apt-get install libcurl4-openssl-dev
sudo bundle install
```

Postgres needs to add the `vagrant` user that your vagrant box runs as by default.
```bash
psql
```
```sql
CREATE USER vagrant;
ALTER ROLE vagrant CREATEUSER CREATEDB;
\q
```

Now you can go ahead and have Rails create and migrate your database then serve up the application.
```bash
rake db:create db:migrate
rails s
```