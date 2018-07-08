Blog

Blog is an Oauth-enabled Blog application integrated with 2 Factor Authentication for Publishing Blogs  

Required Files

Ensure you have an application.yml with the required keys (see config/initializers/figaro.rb for required keys)

Pro Tips™

You can only Add new blogs if you are registered as a New Blog user as you require the country code, Phone details to use the 2 Factor Authentication feature.

Installation

Install the gems: bundle install
Migrate the database: rake db:migrate
Get a copy of application.yml for required env var data

Important gems/libraries used:

authy

We use authy to integrate 2 Factor Authentication to MyBlog

oauth2, doorkeeper

We use oauth2 with doorkeeper to generate access tokens and enable Oauth

omniauth-facebook, omniauth-google-oauth2

We use the above gems for an option to login with Facebook/Google

bcrypt

We use bcrpt to encrypt password

bootstrap

We use bootstrap for implementing UI design.