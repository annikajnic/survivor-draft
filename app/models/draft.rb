class Draft < ApplicationRecord
  belongs_to :draft_owner, class_name: "User"

  has_many :draft_players, dependent: :destroy
  has_many :players, through: :draft_players, source: :user
  has_many :draft_contestants, dependent: :destroy
  has_many :contestants, through: :draft_contestants
  has_many :episodes, dependent: :destroy

  # Players in this draft
  has_many :draft_players, dependent: :destroy
  has_many :players, through: :draft_players, source: :player


  # Episodes for this draft
  has_many :episodes, -> { order(number: :asc) }, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :season_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :episodes_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :airing_datetime, presence: true
  validates :draft_owner, presence: true

  # Scopes
  scope :by_season, ->(season) { where(season_number: season) }
  scope :active, -> { where("airing_datetime <= ?", Time.current) }
  scope :upcoming, -> { where("airing_datetime > ?", Time.current) }

  # Callbacks
  after_create :create_episodes
  after_create :add_owner_as_player

  private

  def create_episodes
    (1..episodes_count).each do |number|
      episodes.create!(
        number: number,
        season_number: season_number,
        air_date: airing_datetime + (number - 1).weeks,
        voting_deadline: airing_datetime + (number - 1).weeks - 1.hour,
        status: number == 1 ? "upcoming" : "upcoming"
      )
    end
  end

  def add_owner_as_player
    draft_players.create!(player: draft_owner)
  end

  def add_contestant(contestant, position)
    draft_contestants.create!(
      contestant: contestant,
      draft_position: position
    )
  end

  def remove_contestant(contestant)
    draft_contestants.find_by(contestant: contestant)&.destroy
  end

  def contestant_positions
    draft_contestants.ordered_by_position.pluck(:contestant_id)
  end
end
