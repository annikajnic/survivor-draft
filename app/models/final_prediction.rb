class FinalPrediction < ApplicationRecord
  belongs_to :user
  belongs_to :contestant

  validates :user_id, presence: true
  validates :contestant_id, presence: true
  validates :placement, presence: true, inclusion: { in: 1..5 }
  validates :jury_votes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validate :unique_placement_per_user
  validate :jury_votes_required_for_top_3

  private

  def unique_placement_per_user
    return unless user.final_predictions.where(placement: placement).exists?
    errors.add(:placement, "has already been used by this user")
  end

  def jury_votes_required_for_top_3
    return unless placement <= 3
    return if jury_votes.present?
    errors.add(:jury_votes, "are required for top 3 placements")
  end
end
