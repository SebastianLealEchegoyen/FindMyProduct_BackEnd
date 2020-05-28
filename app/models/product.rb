class Product < ApplicationRecord
    has_many :list_products
    has_many :lists, through: :list_products

end
