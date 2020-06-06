class ListUser < ApplicationRecord
    belongs_to :list
    belongs_to :user

    validates_uniqueness_of :list_id, :scope => [:user_id]
end
