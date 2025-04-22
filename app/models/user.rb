class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  # Skip confirmation in development
  if Rails.env.development?
    def confirmation_required?
      false
    end
  end

  # Associations
  has_many :drafts_as_owner, class_name: "Draft", foreign_key: "draft_owner_id"
  has_many :draft_players
  has_many :drafts, through: :draft_players
  has_many :votes
  has_many :episodes, through: :votes
  has_many :contestants, through: :votes
  has_many :final_predictions

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  scope :active, -> { where(status: "active") }
  scope :eliminated, -> { where(status: "eliminated") }

  def admin?
    role == "admin"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
