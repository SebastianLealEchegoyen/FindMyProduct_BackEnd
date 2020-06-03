class List < ApplicationRecord
    has_many :list_users
    has_many :users, through: :list_users
    has_many :list_products
    has_many :products, through: :list_products
    validates :name, presence: true

end
