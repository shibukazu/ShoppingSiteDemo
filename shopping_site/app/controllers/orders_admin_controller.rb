class OrdersAdminController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:order_id])
  end
end
