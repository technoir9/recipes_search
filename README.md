# Recipes Search

## Prerequisites

* Ruby 3.0.1
* PostgreSQL >= 9.0

## Configuration

1. Install gems:
   ```
   $ bundle install
   ```
2. Create a database config file from the template:
   ```
   $ cp config/database.yml.template config/database.yml
   ```
3. Set the `username` and `password` variables using
   your PostgreSQL credentials.
4. Database setup:
   ```
   $ rake db:setup
   ```
5. Run the migrations:
   ```
   $ rails db:migrate
   ```
6. Run the server:
   ```
   $ rails s
   ```

You should now be able to open the application in your browser by visiting http://localhost:3000/.

## Import recipes

In order to import the recipes into the database, run the `import_recipes` rake task with specified `RECIPES_URL`:
```
$ RECIPES_URL=http://example.com/recipes.json.gz rake import_recipes
```

## Deployment

[Getting Started on Heroku with Rails 6.x](https://devcenter.heroku.com/articles/getting-started-with-rails6)

1. Create an account on Heroku.
2. Install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#download-and-install).
3. Log in using the Heroku CLI:
    ```
    $ heroku login
    ```
   You will be prompted to enter your Heroku account's email address and password.
4. Create a new Heroku app, either via Heroku dashboard or [using the CLI](https://devcenter.heroku.com/articles/creating-apps):
    ```
    $ heroku create
    ```
5. Deploy the code from the master branch:
    ```
    $ git push heroku master
    ```
6. Run the database migrations:
    ```
    $ heroku run rake db:migrate
    ```
7. Populate the database with recipes (run the command from `Import recipes` section using `heroku run`).
8. You can now visit the app in your browser:
    ```
    $ heroku open
    ```
