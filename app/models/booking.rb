class Booking < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price_in_token, presence: true
  validates :amount_of_days, presence: true
  enum status: %i[pending rejected confirmed ended]

  def calculate_end_date
    self.end_date = start_date + amount_of_days
  end
end
