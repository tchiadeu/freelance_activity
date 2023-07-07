class Item < ApplicationRecord
  UNITY = %w[heure jour].freeze

  belongs_to :bill

  validates :unity, inclusion: { in: UNITY }
end
