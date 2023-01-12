class Tea < ApplicationRecord
  validates_presence_of :title, :description, :temperature, :brewtime, :price
  has_many :subscriptions
end
