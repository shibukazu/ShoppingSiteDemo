class UsersSessionController < ApplicationController
  def new
    @user = User.new()
  end

  def create
    @user = User.find_by(email: user_params[:email].downcase)
    if @user && @user.authenticate(user_params[:password])
      log_in_as_user(@user)
      flash[:notice] = 'ログインしました'
      if user_params[:remember_me] == '1'
        remember(@user)
      else
        forget(@user)
      end
      redirect_back_or(root_url)
    else
      @user = User.new
      if params[:email].empty? && params[:password].empty?
        @user.errors.add(:base, "ログイン情報が入力されていません")
      else
        @user.errors.add(:base, "メールアドレスまたはパスワードが間違っています")
      end
      redirect_to users_session_new_url, flash: {error: @user.errors.full_messages}
    end
  end

  def destroy
    if session[:user_id].nil?
      flash[:warning] = "Failed to logout"
      redirect_to root_url
    else
      flash[:notice] = "Successfully logged out"
      user = User.find(session[:user_id])
      forget(user)
      log_out_as_user()
      redirect_to root_url
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:email, :password, :remember_me)
    end

end
