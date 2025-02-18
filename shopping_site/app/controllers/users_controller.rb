class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @search_word = params[:search]
    if @search_word.nil?
      @orders = @user.orders.order(created_at: "DESC").page(params[:page]).per(5)
    elsif @search_word.empty?
      @orders = @user.orders.order(created_at: "DESC").page(params[:page]).per(5)
    else
      items = Item.search_order_by_item_name(@search_word)
      if items.empty?
        @orders = @user.orders.order(created_at: "DESC").page(params[:page]).per(5)
      else 
        first_item = items.first
        first_orders = first_item.orders.where(user_id: @user.id)
        items.each do |item|
          if item != first_item
            first_orders = first_orders + item.orders.where(user_id: @user.id)
          end
        end
        @orders = Order.where(id: first_orders.map{ |order| order.id }).order(created_at: "DESC").page(params[:page]).per(5)
      end
    end
    
    current_user?(@user)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'アカウントを正常に登録しました'
      log_in_as_user(@user)
      redirect_to root_url
    else
      redirect_to new_user_url, flash: { error: @user.errors.full_messages,
                                        info: { family_name: @user.family_name,
                                                first_name: @user.first_name,
                                                email: @user.email } }

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
