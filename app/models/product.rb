class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true, length: { minimum: 3, maximum: 20, too_short: 'title is too short', too_long: 'title is too long'}
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image'
  }
end
