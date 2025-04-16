class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :votes
  has_many :contestants, through: :votes
  has_many :final_predictions
  has_many :episode_predictions

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: %w[active eliminated] }
  validates :role, presence: true, inclusion: { in: %w[admin user] }

  scope :active, -> { where(status: "active") }
  scope :eliminated, -> { where(status: "eliminated") }

  def admin?
    role == "admin"
  end
end
