class OrdersController < ApplicationController
  
  def new
    if logged_in_as_user? 
      @carts = Cart.where(user_id: session[:user_id]).where(status: 0)
    else
      store_location
      redirect_to users_session_new_url
    end
  end

  def create
    @carts = Cart.where(user_id: session[:user_id]).where(status: 0)
    @order = Order.new(user_id: session[:user_id])
    @carts.each do |cart|
      @order.items << cart.item
    end
    if @order.save
      flash[:notice] = '購入しました'
      @carts.each do |cart|
        cart.destroy
      end
      OrderInfoMailer.send_order_info_to_user(@order).deliver_now
      redirect_to root_url
    else
      
      flash[:warning] = '購入に失敗しました　再度ご注文ください'
      redirect_to carts_url
    end
    
  end

  def show
    @order = Order.find(params[:id])
    current_users_order?(@order.user)
  end

  private
    def current_users_order?(user)
      if !(user.id == session[:user_id])
        redirect_to root_url
      end
    end

  
end
