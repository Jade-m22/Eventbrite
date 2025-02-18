class Event < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :destroy
  has_many :participants, through: :attendances, source: :user
  validates :start_date, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, multiple_of: 5 }
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, inclusion: { in: 0..1000 }
  validates :location, presence: true
end
