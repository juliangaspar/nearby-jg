class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_validation :geocode, if: :will_save_change_to_address?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  geocoded_by :address
  has_many :messages, dependent: :destroy
  has_one_attached :photo
  has_many :participants, dependent: :destroy
  has_many :chatrooms, through: :participants
  has_many :bookings
  has_many :items, dependent: :destroy
  has_many :rented_items, through: :bookings, source: :item, dependent: :destroy
  # Pending validations on pictures (id, profile)
  validates :email, :first_name, :last_name, :username, :address, presence: true
  validates :username, uniqueness: true

  def average_rating
    return nil if booking_reviews.count.zero?

    sum = 0
    booking_reviews.each do |review|
      sum += review.rating
    end
    return (sum.to_f / booking_reviews.count).round(1)
  end

  def booking_reviews
    Review.joins(booking: :item).where("items.user_id=?", self.id)
  end
end
