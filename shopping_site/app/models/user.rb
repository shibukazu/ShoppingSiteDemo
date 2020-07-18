class User < ApplicationRecord
    VALID_EMAIL_REGIX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    has_many :carts, dependent: :destroy
    has_many :items, through: :carts
    has_many :orders, dependent: :destroy
    has_secure_password
    before_save :down_case_email
    before_save :full_name
    validates :first_name, presence: true
    validates :family_name, presence: true
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGIX},
                    uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 10}, presence: true
    #columnでないremember_tokenを外部参照できるように
    attr_accessor :remember_token

    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def self.new_token
        SecureRandom.urlsafe_base64
    end

    

    def authenticated?(remember_token)
        BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
    end


    private
        def down_case_email
            self.email.downcase!
        end

        def full_name
            self.name = "#{self.family_name} #{self.first_name}"
        end
end
