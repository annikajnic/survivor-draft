class Contestant < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  has_many :final_predictions

  validates :name, presence: true, uniqueness: { scope: :season_number }
  validates :tribe, presence: true
  validates :status, presence: true, inclusion: { in: %w[active inactive] }
  validates :season_number, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :active, -> { where(status: "active") }
  scope :inactive, -> { where(status: "inactive") }
  scope :by_season, ->(season) { where(season_number: season) }
end
