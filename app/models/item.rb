class Item < ApplicationRecord
  UNITY = %w[unité heure jour].freeze

  belongs_to :bill

  validates :unity, inclusion: { in: UNITY }
end
