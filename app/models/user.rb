class User < ApplicationRecord
  has_many :events, dependent: :destroy
  
  validates_presence_of :email, :name, :password
end
