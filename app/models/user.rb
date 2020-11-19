class User < ApplicationRecord
  has_many :events
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  scope :upcoming, -> { where('date >= ?', Date.today) }
  scope :past, -> { where('date < ? ', Date.today) }
end
