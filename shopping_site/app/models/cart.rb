class Cart < ApplicationRecord
    belongs_to :user
    belongs_to :item
    belongs_to :order
    validates :user_id, presence: true
    validates :item_id, presence: true
    validates :order_id, presence: true
end
