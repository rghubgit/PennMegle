class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.integer :session_id
      t.references :channel, foreign_key: true

      t.timestamps
    end
    #add_foreign_key :rooms, :channels, column: :room_id
  end
end
