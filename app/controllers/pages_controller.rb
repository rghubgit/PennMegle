class PagesController < ApplicationController
  def home
    @rooms = Room.all

    # limits room lifespan. 
    # Rooms are automatically destroyed when there are 0 remaining users
    Room.all.each do |room|
      begin
        len = get_opentok.streams.all(room.session_id).length
      rescue
      ensure
        if len == 0
          room.destroy
        end
      end
    end
  end
end