module AdminsSessionHelper
    def log_in_as_admin(admin)
        session[:admin_id] = admin.id
    end

    def log_out_as_admin()
        session.delete(:admin_id)
    end

    def logged_in_as_admin?()
        return !session[:admin_id].nil?
    end
end
