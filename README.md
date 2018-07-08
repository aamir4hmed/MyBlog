Blog

Blog is an Oauth-enabled Blog application integrated with 2 Factor Authentication for Publishing Blogs  

Rails version: 5.1.6

Ruby version used: 2.3.5

Required Files

Ensure you have an application.yml with the required keys (see config/initializers/figaro.rb for required keys)

Pro Tips™

You can only Add new blogs if you are registered as a New Blog user as you require the country code, Phone details to use the 2 Factor Authentication feature.

Setup

Visit https://www.twilio.com/console to set up an Authy Account,created a Task, generated an API Key and referred to https://www.twilio.com/docs/tutorials to implement 2FA

Create a google,facebook application to generate APPID and key for omniauth

Implement Doorkeeper with Oauth to generate UID, Access Tokens for Oauth

Implement Bootstrap v4 for simple UI design

Install the gems: bundle install
Migrate the database: rake db:migrate
Get a copy of application.yml for required env var data
Run the application

Important gems/libraries installed:

# authy to integrate 2 Factor Authentication to MyBlog

authy:

# oauth2, doorkeeper to generate access tokens and enable Oauth for New Blog

oauth2, doorkeeper

# Login using Facebook/Google

omniauth-facebook, omniauth-google-oauth2

Setting up the environment variables

figaro:

Bcrpt to encrypt password

bcrypt:

bootstrap for implementing UI design.

bootstrap:



Deployment using Heroku:

Generate Privacy policy for Facebook and Google Apps for Production ready application

heroku login

Install Ruby > 2.3.5

Replace 'sqlite3' gem with 'pg' gem

bundle install

# Creates Heroku live application "https://myblog-2fa.herokuapp.com/"
heroku create myblog-2fa

#Push git repository code to Heroku
git push heroku master

# Set Environment variables from application.yml file into Heroku config
figaro heroku:set -e production

# Migrate into Heroku's Postgres Database
heroku run rake db:migrate

Visited https://myblog-2fa.herokuapp.com/


