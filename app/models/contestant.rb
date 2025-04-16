class Contestant < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  has_many :final_predictions

  validates :name, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w[active eliminated] }

  scope :active, -> { where(status: "active") }
  scope :eliminated, -> { where(status: "eliminated") }
end
