class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :order_items

  validates :name, presence: true, uniqueness: true, length: {in: 4..95}
  validates :description, presence: true, length: { in: 10..1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.00 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_attached_file :photo, styles: {
                               thumb: '100x100>',
                               square: '200x200#',
                               medium: '300x300>'
                           }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png'] #/\Aimage\/.*\Z/

  before_destroy :ensure_not_referenced_by_any_order_item

  private

  def ensure_not_referenced_by_any_order_item
    if order_items.empty?
      return true
    else
      errors.add(:base, 'order items exist')
      return false
    end
  end

end
