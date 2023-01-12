class Subscription < ApplicationRecord
  validates_presence_of :customer_id, :tea_id, :title, :total_price, :frequency, :status
  belongs_to :customer
  belongs_to :tea

  enum status: { cancelled: 0, active: 1 }
  enum frequency: { weekly: 0, bi_weekly: 1, monthly: 2 }
end
