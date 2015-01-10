class AddRatingToProduct < ActiveRecord::Migration
  def change
    add_column :products, :rating, :string, default: 0
  end
end
