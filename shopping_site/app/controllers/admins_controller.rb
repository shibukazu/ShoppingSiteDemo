class AdminsController < ApplicationController
  #before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :admin?, only: [:index, :new, :create, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.page(params[:page]).per(20)
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(create_admin_params)
    if @admin.save
      flash[:notice] = 'Admin was successfully created.' 
      redirect_to admins_url
    else
      render :new 
    end
  end
  

  def destroy
    @admin = Admin.find(params[:id]).destroy
    redirect_to admins_url
    flash[:notice] = 'Admin was successfully destroyed.'
  end

  private
    # Only allow a list of trusted parameters through.
    def create_admin_params
      params.require(:admin).permit(:email, :password, :password_confirmation)
    end

    def login_admin_params
      params.require(:admin).permit(:email, :password)
    end

    def admin?
      if session[:admin_id].nil?
        
        redirect_to root_url
      elsif Admin.find(session[:admin_id]).nil?
        redirect_to root_url
      end
    end
end
