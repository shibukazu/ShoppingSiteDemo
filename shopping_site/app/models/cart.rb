class Cart < ApplicationRecord
    belongs_to :user
    belongs_to :item
    belongs_to :
    validates :user_id, presence: true
    validates :item_id, presence: true
end
