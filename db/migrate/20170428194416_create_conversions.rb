class CreateConversions < ActiveRecord::Migration[5.0]
  def change
    create_table :conversions do |t|
      t.string :name
      t.string :symbol
      t.float :factor
      t.string :unit

      t.timestamps
    end
  end
end
