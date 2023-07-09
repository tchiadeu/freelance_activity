class CreateBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :bic_number
      t.string :iban_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
