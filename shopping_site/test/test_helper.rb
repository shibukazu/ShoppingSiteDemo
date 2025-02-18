ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified worker
  
  parallelize(workers: :number_of_processors)
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  def con_log_in_as_admin(admin)
    session[:admin_id] = admin.id
  end

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def log_in_as_admin(admin)
    post admins_session_create_path, params: { email: admin.email,
                                              password: admin.password }
  end
  
  def log_in_as_user(user)
    post users_session_create_path, params: { email: user.email,
                                              password: "1234567890" }
  end
end