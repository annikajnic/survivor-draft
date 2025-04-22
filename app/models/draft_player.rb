class DraftPlayer < ApplicationRecord
  belongs_to :draft
  belongs_to :player, class_name: "User"

  validates :draft, presence: true
  validates :player, presence: true
  validates :player_id, uniqueness: { scope: :draft_id }
end
