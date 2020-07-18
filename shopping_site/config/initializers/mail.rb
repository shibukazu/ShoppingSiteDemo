if Rails.env.production?
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
        address: 'smtp.gmail.com',
        domain: 'gmail.com',
        port: 587,
        user_name: "製品版で実装",
        password: '',
        authentication: 'plain',
        enable_starttls_auto: true
    }
elsif Rails.env.development?
    ActionMailer::Base.delivery_method = :letter_opener
    host = 'localhost:3000'
    Rails.application.routes.default_url_options[:host] = host

else
    ActionMailer::Base.delivery_method = :test
    host = 'localhost:3000'
    Rails.application.routes.default_url_options[:host] = host
end