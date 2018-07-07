require 'authy'

Authy.api_key = Rails.application.secrets.authy_key
Authy.api_uri = Rails.application.secrets.api_uri