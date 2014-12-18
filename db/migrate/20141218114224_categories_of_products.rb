class CategoriesOfProducts < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.integer :category_id
      t.integer :product_id
    end
    add_index :categories_products, [:category_id, :product_id]
  end
end
