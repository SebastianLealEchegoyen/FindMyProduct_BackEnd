class ListProduct < ApplicationRecord
    belongs_to :list
    belongs_to :product

    #validates_uniqueness_of :list_id, :scope => [:product_id]

end
