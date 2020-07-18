module UsersSessionHelper
    def log_in_as_user(user)
        session[:user_id] = user.id
    end

    def log_out_as_user()
        
        session.delete(:user_id)
        
    end

    def logged_in_as_user?()
        if !session[:user_id].nil?
            return true
        elsif !cookies.signed[:user_id].nil?
            user = User.find(cookies.signed[:user_id])
            if user && user.authenticated?(cookies[:remember_token])
                session[:user_id] = cookies.signed[:user_id]
                return true
            else
                return false
            end
        else
            return false
        end
    end

    def redirect_back_or(default)
        
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    def store_location
        session[:forwarding_url] = (request.original_url)
    end

    def remember(user)
        user.remember_token = User.new_token
        user.update_attribute(:remember_digest, User.digest(user.remember_token))
        cookies.parmanent.signed[:user_id] = user.id
        cookies.parmanent[:remember_token] = user.remember_token
    end

    def forget(user)
        user.update_attribute(:remember_digest, nil)
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
end
