require "opentok"

# Schema:
# name: string
# description: text
# session_id: integer
# channel: references

class Room < ApplicationRecord

  # validations
  validates :name, presence:true   

  # relationships
  belongs_to :channel
  has_many :users

  # initializes OpenTok API
  def config_opentok
    tries = 3
    begin
      @opentok = OpenTok::OpenTok.new Rails.application.credentials.vonage[:api_key], Rails.application.credentials.vonage[:secret]
      logger.debug "opentok connected."
     rescue Errno::ETIMEDOUT => e
      log.error e 
      tries -= 1
        if tries > 0
          logger.debug "retrying opentok.new..."
        retry 
        else
          logger.debug "opentok.new timed out..."
          puts "ERROR: #{e.message}" 
        end
    end
    @opentok
  end

  # getter: returns session
  def session
    @session
  end

  # setter: sets session
  def session=(new_session)
    @session = new_session
  end
end
