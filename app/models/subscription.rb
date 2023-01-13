class Subscription < ApplicationRecord
  validates_presence_of :customer_id, :tea_id, :title, :total_price, :frequency, :status
  belongs_to :customer
  belongs_to :tea

  enum status: { cancelled: 0, active: 1 }
  enum frequency: { weekly: 0, bi_weekly: 1, monthly: 2 }

  def self.calculate_price(frequency, tea_price)
    case frequency
    when 'weekly'
      tea_price
    when 'bi_weekly'
      tea_price * 2
    when 'monthly'
      tea_price * 4
    else
      tea_price * 0
    end
  end
end
