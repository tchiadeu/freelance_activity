class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.integer :number
      t.decimal :total_amount
      t.boolean :payed
      t.integer :year
      t.string :month
      t.date :emission_date
      t.date :due_date
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
