class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :authy_id
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :country_code
      t.string :phone
      t.boolean :verified
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.string :oauth_expires_at

      t.timestamps
    end
  end
end
