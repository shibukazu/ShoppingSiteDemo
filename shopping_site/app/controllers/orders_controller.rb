class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = '注文は正常に処理されました'
      log_in_as_user(@order)
      redirect_to root_url
    else
      flash[:warning] = '注文に失敗しました　再度ご注文ください'
      redirect_to carts_url
    end
    
  end

  def show
  end

  private
   def order_params()
    params.require(:order).permit(:user_id, :status)
   end
end
