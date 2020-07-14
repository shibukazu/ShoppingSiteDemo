class Admin < ApplicationRecord
    has_secure_password
    before_save :down_case_email

    private
        def down_case_email
            self.email.downcase!
        end
end
