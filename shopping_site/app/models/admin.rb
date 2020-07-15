class Admin < ApplicationRecord
    VALID_EMAIL_REGIX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    has_secure_password
    before_save :down_case_email
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGIX},
                    uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 8}, presence: true
    private
        def down_case_email
            self.email.downcase!
        end
end
