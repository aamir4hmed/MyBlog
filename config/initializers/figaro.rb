# Here you can find all required environment
# variables to get this app up and running.

# Don't run figaro for tests as we keep
# getting Figaro::MissingKeys error.
unless %w(test).include? Rails.env
  # Essentials
  Figaro.require_keys(
    # Twilio-Authy
    'authy_api_key',
    'authy_api_uri',

    # omniauth
    'oauth_app_id',
    'oauth_secret',

    # google
    'google_app_id',
    'google_secret',

    # facebook
    'facebook_app_id',
    'facebook_secret',

    # Doorkeeper
    'oauth_redirect_uri',
    'server_base_url'

  )
end
