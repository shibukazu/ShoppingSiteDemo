class Order < ApplicationRecord
    has_many :order_pairs, dependent: :destroy
    has_many :items, through: :order_pairs
    belongs_to :user
end
