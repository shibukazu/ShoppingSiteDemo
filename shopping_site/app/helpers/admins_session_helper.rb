module AdminsSessionHelper
    def log_in_as_admin(admin)
        session[:admin_id] = admin.id
    end
end
