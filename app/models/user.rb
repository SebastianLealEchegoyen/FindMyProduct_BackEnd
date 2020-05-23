class User < ApplicationRecord
    has_many :list_users
    has_many :lists, through: :list_users
    
    has_secure_password
    validates :username, presence: true, uniqueness: true

end
