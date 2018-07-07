class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :content
      t.string :article_status
      t.boolean :verify
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
