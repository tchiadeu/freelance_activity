class Prospect < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :place_of_knowledge, presence: true
  validates :relation_type, inclusion: { in: ['Professionnelle', 'Personnelle', 'Les deux'] }, presence: true
  validates :proximity_level, inclusion: { in: (1..10) }, presence: true
  validates :network_power, inclusion: { in: (1..10) }, presence: true
  validates :activity_area, presence: true
  validates :city, presence: true
end
