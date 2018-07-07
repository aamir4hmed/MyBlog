require 'bcrypt'
class User < ApplicationRecord
  has_secure_password
  has_many :blogs
  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all
  has_one :application, class_name: "Doorkeeper::Application",
                           foreign_key: :uid
                    
  validates :email,  presence: true, format: { with: /\A.+@.+$\Z/ }, uniqueness: true
  validates :password_digest, presence: true
  validates :name, presence: true
  validates :country_code, presence: true
  validates :phone, presence: true

 
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password_digest = BCrypt::Password.create(auth.uid)
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end 
  end
end