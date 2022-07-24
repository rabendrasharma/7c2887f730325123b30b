class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.text :commands, array: true#, default: []

      t.timestamps
    end
  end
end
