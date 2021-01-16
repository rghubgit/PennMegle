# Schema:
# name: string
# description: text

class Channel < ApplicationRecord
  validates :name, presence:true
  validates :description, presence:true   

  has_many :rooms, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations

  def self.ranked_subscribers 
    self.all.sort_by {|obj| -obj.users.length}
  end
end
