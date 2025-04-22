class DraftContestant < ApplicationRecord
  belongs_to :draft
  belongs_to :contestant

  validates :draft, presence: true
  validates :contestant, presence: true
  validates :contestant_id, uniqueness: { scope: :draft_id }

  validate :contestant_season_matches_draft

  private

  def contestant_season_matches_draft
    if contestant.season_number != draft.season_number
      errors.add(:contestant, "must be from the same season as the draft")
    end
  end
end
