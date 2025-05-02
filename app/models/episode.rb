class Episode < ApplicationRecord
  has_many :votes
  has_many :episode_predictions
  has_many :contestants, through: :votes
  has_many :users, through: :votes

  validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :air_date, presence: true
  validates :voting_deadline, presence: true
  validates :season_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :number, uniqueness: { scope: :season_number }
  validates :status, presence: true, inclusion: { in: %w[upcoming current completed] }

  scope :upcoming, -> { where(status: "upcoming") }
  scope :current, -> { where(status: "current") }
  scope :completed, -> { where(status: "completed") }
  scope :final, -> { where(is_final: true) }
  scope :by_season, ->(season) { where(season_number: season) }
  scope :current_season, -> { where(season_number: Contestant.maximum(:season_number)) }

  def self.past_episodes
    completed
  end

  def self.current_episode
    current_season.where("air_date < ?", Time.current)
                 .order(number: :desc)
                 .first
  end

  def voting_open?
    status == "current" && Time.current < voting_deadline
  end
end
