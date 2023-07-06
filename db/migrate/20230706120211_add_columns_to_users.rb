class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :post_code, :string
    add_column :users, :city, :string
    add_column :users, :siret_number, :integer
    add_column :users, :tva_number, :string
  end
end
