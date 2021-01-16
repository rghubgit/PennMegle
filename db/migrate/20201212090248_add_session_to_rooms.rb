class AddSessionToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :session_id, :string
  end
end
