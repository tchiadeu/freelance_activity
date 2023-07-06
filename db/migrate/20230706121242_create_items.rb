class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :unity
      t.decimal :quantity
      t.decimal :unit_price
      t.decimal :total_price
      t.references :bill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
