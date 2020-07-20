class AdminsSessionController < ApplicationController
  
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.find_by(email: admin_params[:email].downcase)
    if @admin && @admin.authenticate(admin_params[:password])
      log_in_as_admin(@admin)
      redirect_to admins_path
    else
      @admin = Admin.new
      @admin.errors.add(:base, "ログイン情報が正しくありません")
      redirect_to admins_session_new_url, flash: { error: @admin.errors.full_messages }
    end
  end

  def destroy
    log_out_as_admin()
    redirect_to root_url
  end

  private

  def admin_params
    params.permit(:email, :password)
  end

end
