class Episode < ApplicationRecord
  has_many :votes
  has_many :episode_predictions

  validates :number, presence: true, uniqueness: true
  validates :air_date, presence: true
  validates :voting_deadline, presence: true
  validates :status, presence: true, inclusion: { in: %w[upcoming current completed] }

  scope :upcoming, -> { where(status: "upcoming") }
  scope :current, -> { where(status: "current") }
  scope :completed, -> { where(status: "completed") }
  scope :final, -> { where(is_final: true) }

  def self.current_episode
    current.first
  end

  def voting_open?
    status == "current" && Time.current < voting_deadline
  end
end
