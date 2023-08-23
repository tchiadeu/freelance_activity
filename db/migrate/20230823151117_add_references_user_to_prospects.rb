class AddReferencesUserToProspects < ActiveRecord::Migration[7.0]
  def change
    add_reference :prospects, :user, null: false, foreign_key: true
  end
end
