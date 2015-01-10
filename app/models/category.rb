class Category < ActiveRecord::Base
  has_and_belongs_to_many :products

  acts_as_list
  default_scope { order('position ASC') }

end
