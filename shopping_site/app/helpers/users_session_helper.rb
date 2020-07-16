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

    def redirect_back_or(default)
        
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    def store_location
        session[:forwarding_url] = (request.original_url)
    end
end
