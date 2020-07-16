class AdminsSessionController < ApplicationController
  
  def new
    
  end

  def create
    @admin = Admin.find_by(email: admin_params[:email].downcase)
    if @admin && @admin.authenticate(admin_params[:password])
      log_in_as_admin(@admin)
      redirect_to admins_path
    else
      flash[:warning] = "Invalid admin user"
      redirect_to root_url
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
