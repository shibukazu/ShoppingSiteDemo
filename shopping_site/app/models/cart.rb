class Cart < ApplicationRecord
    belongs_to :user
    belongs_to :item
    validates :uset_id, presence: true
    validates :item_id, presence: true
end
