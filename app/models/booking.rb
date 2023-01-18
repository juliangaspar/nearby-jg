class Booking < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :reviews

  enum status: %i[pending rejected confirmed ended]

  def calculate_end_date
    self.end_date = start_date + amount_of_days
  end
end
