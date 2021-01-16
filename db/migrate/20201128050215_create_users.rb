class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :password_hash
      t.text :bio
      # t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
