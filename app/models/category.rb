class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :products_categories
  has_ancestry

end
