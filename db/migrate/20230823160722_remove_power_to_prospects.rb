class RemovePowerToProspects < ActiveRecord::Migration[7.0]
  def change
    remove_column :prospects, :power, :string
  end
end
