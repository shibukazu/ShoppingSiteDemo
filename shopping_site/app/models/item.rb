class Item < ApplicationRecord
    mount_uploader :image, ImageUploader
    validates :name, presence: true, uniqueness: true
    validates :price, presence: true
    has_many :carts, dependent: :destroy
    has_many :items, through: :carts
    has_many :order_pairs, dependent: :destroy
    has_many :orders, through: :order_pairs

    def self.search_by_name(search)
        if search.nil?
            return Item.all
        else 
            return Item.where("UPPER(name) LIKE ?", "%#{search.upcase}%")
        end
    end
end
