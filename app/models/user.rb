class User < ApplicationRecord
  after_create :send_welcome_email

    has_many :events, dependent: :destroy
    has_many :attendances
    has_many :events_participated, through: :attendances, source: :event
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :description, length: { maximum: 500 }

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
end
