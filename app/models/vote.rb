class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :contestant
  belongs_to :episode

  validates :user_id, presence: true
  validates :contestant_id, presence: true
  validates :episode_id, presence: true
  validate :user_can_vote
  validate :contestant_is_active
  validate :no_duplicate_votes
  validate :voting_is_open

  private

  def user_can_vote
    return if user.active?
    errors.add(:user, "is eliminated and cannot vote")
  end

  def contestant_is_active
    return if contestant.active?
    errors.add(:contestant, "is eliminated and cannot be voted for")
  end

  def no_duplicate_votes
    return unless user.votes.where(contestant_id: contestant_id).exists?
    errors.add(:contestant, "has already been voted for by this user")
  end

  def voting_is_open
    return if episode.voting_open?
    errors.add(:episode, "voting is closed")
  end
end
