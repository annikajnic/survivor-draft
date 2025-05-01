class DraftContestant < ApplicationRecord
  belongs_to :draft
  belongs_to :contestant

  validates :draft_position, presence: true, uniqueness: { scope: :draft_id }
  validates :contestant_id, uniqueness: { scope: :draft_id }

  scope :active, -> { where(is_eliminated: false) }
  scope :eliminated, -> { where(is_eliminated: true) }
  scope :ordered_by_position, -> { order(draft_position: :asc) }
  scope :by_tribe, ->(tribe) { where(tribe: tribe) }

  validate :contestant_season_matches_draft

  def eliminate!
    update!(is_eliminated: true, eliminated_at: Time.current)
  end

  private

  def contestant_season_matches_draft
    if contestant.season_number != draft.season_number
      errors.add(:contestant, "must be from the same season as the draft")
    end
  end
end
