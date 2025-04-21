class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :votes
  has_many :episodes, through: :votes
  has_many :contestants, through: :votes
  has_many :final_predictions

  validates :first_name, presence: true
  validates :last_name, presence: true
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
