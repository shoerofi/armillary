class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.references :seat, foreign_key: true
      t.string :position
      t.integer :row
      t.integer :col
      t.integer :no

      t.timestamps
    end
  end
end
