class AddCustomerFkColToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_reference :subscriptions, :customer, foreign_key: true
  end
end
