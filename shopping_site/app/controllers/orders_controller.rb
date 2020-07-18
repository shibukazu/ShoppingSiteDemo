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
      flash[:notice] = '注文は正常に処理されました'
      @carts.each do |cart|
        cart.destroy
      end
      redirect_to root_url
    else
      
      flash[:warning] = '注文に失敗しました　再度ご注文ください'
      redirect_to carts_url
    end
    
  end

  def show
    @order = Order.find(params[:id])
  end

  
end
