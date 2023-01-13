class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.float :total_price
      t.integer :frequency
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
