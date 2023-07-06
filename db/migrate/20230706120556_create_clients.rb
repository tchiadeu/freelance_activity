class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :post_code
      t.string :city
      t.integer :siret_number
      t.string :tva_number
      t.string :phone_number
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
