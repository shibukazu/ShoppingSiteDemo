require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
    def setup
        @master = admins(:master)
        @admin = Admin.new(email: "master@test.com", password: "1234567890")
        @invalid_admin = Admin.new(email: "invalid@example.com", password: "1234567890")
        @new_admin = Admin.new(email: "new@example.com", password: "1234567890", password_confirmation: "1234567890")
    end

    test "should be able to see admin's page with valid login" do
        log_in_as_admin(@admin)
        get admins_path
        assert_template "admins/index"
    end

    test "should not be able to see admin's page without login" do
        get admins_path
        assert_redirected_to root_path
    end

    test "should not be able to see admin's page with invalid login" do
        log_in_as_admin(@invalid_admin)
        get admins_path
        assert_redirected_to root_path
    end

    test "should not be able to create new admin without valid login" do
        
        assert_no_difference 'Admin.count' do
            post admins_path, params: {admin: { email: @new_admin.email,
                                            password: @new_admin.password,
                                            password_confirmation: @new_admin.password_confirmation
                                            } }
        end
        assert_redirected_to root_path
    end

    test "should not be able to delete admin without valid login" do
        assert_no_difference 'Admin.count' do
            delete admin_path(@master)
        end
        assert_redirected_to root_path
    end

end
