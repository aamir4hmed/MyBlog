# MyBlog

	Blog is an Oauth-enabled Blog application integrated with 2 Factor Authentication for Publishing Blogs with an option to sign-in using Facebook or Google. 

## Rails version:
		
		5.1.6

## Ruby version: 
		
		2.3.5

## Required Files

	Ensure you have an application.yml with the required keys (see config/initializers/figaro.rb for required keys)

## Pro Tips™

	You can only Add new blogs if you are registered as a New Blog user as you require the country code, Phone details to use the 2 Factor Authentication feature.

## Setup

	- Visit https://www.twilio.com/console to set up an Authy Account.
	 	- create a Task
	 	- Generate an API Key
		- Referred to https://www.twilio.com/docs/tutorials to implement 2FA

	- Create a google,facebook application to generate APPID and key for 	omniauth

	- Implement Doorkeeper with Oauth to generate UID, Access Tokens for Oauth

	- Implement Bootstrap v4 for simple UI design

	- bundle install
	Installs the gems in the Gemfile
	- rake db:migrate
	Migrates the database 
	- Get a copy of application.yml for required env var data
	- Run the application

## Important gems/libraries installed:

	- ### authy:
		authy to integrate 2 Factor Authentication to MyBlog

	- ### oauth2, ### doorkeeper:
		oauth2, doorkeeper to generate access tokens and enable Oauth for New Blog

	- ### omniauth-facebook, ### omniauth-google-oauth2:
		Login using Facebook/Google

	- ### figaro:
		Setting up the environment variables

	- ### bcrypt:
		Bcrpt to encrypt password

	- ### bootstrap:
		bootstrap for implementing UI design.

## Deployment using Heroku:

	- Generate Privacy policy for Facebook and Google Apps for 
		Production ready application.

	### heroku login

	- Install Heroku CLI

	- Install Ruby > 2.3.5

	- Replace 'sqlite3' gem with 'pg' gem

	- bundle install

	- heroku create 'Application-name'
		
	- git push heroku master
		Push git repository code to Heroku

	- figaro heroku:set -e production
		Set Environment variables from application.yml file into Heroku 
		config

	- heroku run rake db:migrate
		Migrate into Heroku's Postgres Database
