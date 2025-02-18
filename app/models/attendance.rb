class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates :stripe_customer_id, presence: true

  after_create :send_participant_email

  private

  def send_participant_email
    UserMailer.participant_email(self).deliver_now
  end
end
