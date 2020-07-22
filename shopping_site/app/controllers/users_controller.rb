class UsersController < ApplicationController
  

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @orders = @user.orders.order(created_at: "DESC").page(params[:page]).per(10)
    current_user?(@user)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'アカウントを作成しました'
      log_in_as_user(@user)
      redirect_to root_url
    else
      redirect_to new_user_url, flash: { error: @user.errors.full_messages }

    end
    
  end

  

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :family_name, :email, :password, :password_confirmation)
    end

    def current_user?(user)
      if !(user.id == session[:user_id])
        redirect_to root_url
      end
    end
end
