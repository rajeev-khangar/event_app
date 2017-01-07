class Event < ApplicationRecord
  belongs_to :user
  
  validates_presence_of :name, :user_id, :event_date  
end
