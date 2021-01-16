# Schema:
# user: references
# channel: references

class Registration < ApplicationRecord
  belongs_to :channel
  belongs_to :user
end
