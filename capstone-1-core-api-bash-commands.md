# bash commands


### start git repo

```bash
mkdir capstone-1-core-api
cd capstone-1-core-api
touch README.md
git add README.md
git commit -m "Initial commit"
```


### Instantiate a Rails server application.

```bash
rails new . -T -d postgresql --api
```

### Configure the application for use with a relational and MongoDB database for development and test profiles.

edit `config/databases.yml` and run:

``` bash
rake db:setup
rake db:migrate
```

Generate a config file by executing the generator and then editing `/config/mongoid.yml`

```bash
rails g mongoid:config
```

Add to `config/application.rb`:

```ruby
Mongoid.load!('./config/mongoid.yml')

# default ORM are we using with scaffold
config.generators {|g| g.orm :active_record}
#config.generators {|g| g.orm :mongoid}
```

Generate the tests:

```bash 
rails g rspec:install
rails g rspec:request APIDevelopment
``` 

Run the tests:

```bash
rspec
```

### Display information indicating the site is under construction.

```bash
rails g controller ui --no-assets --no-helper
```

Modify `config/routes.rb` and create `app/views/index.html.erb`

### Implement an end-to-end thread from the API to the relational database for a resource called `Cities`.

The api_only config option makes posible to have our Rails application working excluding those middlewares and controller modules that are not needed in an API only application. 

```ruby
config.api_only = true
```

Generate the `City` model:

```bash
rails-api g scaffold City name --orm active_record --no-request-specs --no-routing-specs --no-controller-specs --no-helper-specs

rake db:migrate
```

### Implement an end-to-end thread from the API to the MongoDB database for a resource called States.

Generate the `State` model:

```bash
rails-api g scaffold City name --orm mongoid --no-request-specs --no-routing-specs --no-controller-specs --no-helper-specs
```


### Configure your staging and production sites to require HTTPS for web communications

Edit `config/environments/production.rb` and `config/environments/staging.rb`

```ruby
# Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
config.force_ssl = true
```

### Add seeds for Cities and States

Edit `db/seeds.rb`

### Configure CORS

Add to Gemfile:
```ruby
gem 'rack-cors', require: 'rack/cors'
```

Add to `config/application.rb`:

```ruby
config.middleware.insert_before 0, "Rack::Cors" do
  allow do 
    origins '*'

    resource '/api/*',
      headers: :any,
      methods: [:get, :post, :put, :delete, :options]
  end      
end
```

### Deployment

Go to [mLab](https://www.mlab.com) and create the databases for staging and production environments.

Create the `staging` app in [Heroku](https://heroku.com):

```bash
heroku create capstone-1-core-api-staging --remote staging
git checkout staging-app
git push staging staging-app:master

heroku run rake db:migrate --remote staging

heroku config --remote staging
heroku config:add RAILS_ENV=staging --remote staging

heroku config:set MLAB_URI=mongodb://<dbuser>:<dbpassword>@ds115110.mlab.com:15110/capstone-1-core-api_staging --remote staging

heroku run rake db:seed --remote staging
```


```bash
heroku create capstone-1-core-api --remote production
git checkout master
git push production master

heroku run rake db:migrate --remote production

heroku config --remote production

heroku config:set MLAB_URI=mongodb://<dbuser>:<dbpassword>@ds115110.mlab.com:15110/capstone-1-core-api_production --remote staging
```
