class RemoveTotalPriceToItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :total_price
  end
end
