class Product < ApplicationRecord
    has_many :list_products
    has_many :lists, through: :list_products
    scope :search_name, ->(name) { where("name LIKE ?", "%"+name+"%" ) }  

end
