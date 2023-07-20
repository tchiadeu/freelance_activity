class AddTaxesToBills < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :taxes, :boolean
  end
end
