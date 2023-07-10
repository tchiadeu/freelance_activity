class Client < ApplicationRecord
  belongs_to :user
  has_many :bills

  validates :name, presence: true, uniqueness: true
end
