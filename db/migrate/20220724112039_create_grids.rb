class CreateGrids < ActiveRecord::Migration[6.0]
  def change
    create_table :grids do |t|
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.string :direction
      t.integer :robot_id

      t.timestamps
    end
  end
end
