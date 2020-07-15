module UsersSessionHelper
    def log_in_as_user(user)
        session[:user_id] = user.id
    end

    def log_out_as_user()
        
        session.delete(:user_id)
        
    end

    def logged_in_as_user?()
        return !(session[:user_id].nil?)
    end
end
