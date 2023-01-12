class AddTeaFkColToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_reference :subscriptions, :tea, foreign_key: true
  end
end
