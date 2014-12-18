class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories

  validates :name, presence: true, uniqueness: true, length: {in: 4..15}
  validates :description, presence: true, length: { in: 10..100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.00 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_attached_file :photo, styles: {
                               thumb: '100x100>',
                               square: '200x200#',
                               medium: '300x300>'
                           }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

end
