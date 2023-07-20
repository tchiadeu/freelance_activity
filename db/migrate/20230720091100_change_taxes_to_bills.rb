class ChangeTaxesToBills < ActiveRecord::Migration[7.0]
  def change
    change_column :bills, :taxes, :boolean, default: false
  end
end
