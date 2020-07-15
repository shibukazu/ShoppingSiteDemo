class Item < ApplicationRecord
    mount_uploader :image, ImageUploader
    validates :name, presence: true, uniqueness: true
    validates :price, presence: true
    has_many :carts, dependent: :destroy
    has_many :items, through: :carts
end
