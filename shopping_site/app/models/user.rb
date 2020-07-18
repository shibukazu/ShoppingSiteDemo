class User < ApplicationRecord
    VALID_EMAIL_REGIX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    has_many :carts, dependent: :destroy
    has_many :items, through: :carts
    has_many :orders, dependent: :destroy
    has_secure_password
    before_save :down_case_email
    validates :name, presence: true
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGIX},
                    uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 10}, presence: true

    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    private
        def down_case_email
            self.email.downcase!
        end
end
