class CreateProspects < ActiveRecord::Migration[7.0]
  def change
    create_table :prospects do |t|
      t.string :name
      t.string :place_of_knowledge
      t.string :relation_type
      t.integer :proximity_level
      t.integer :power
      t.integer :network_power
      t.integer :activity_area
      t.string :city
      t.boolean :contacted, default: false
      t.boolean :called, default: false
      t.boolean :signed, default: false

      t.timestamps
    end
  end
end
