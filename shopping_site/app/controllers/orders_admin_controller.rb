class OrdersAdminController < ApplicationController
  before_action :admin?
  def index
    @search_word = params[:search]
    if @search_word.nil?
      @orders = Order.order(created_at: "DESC").page(params[:page]).per(5)
    elsif @search_word.empty?
      @orders = Order.order(created_at: "DESC").page(params[:page]).per(5)
    else
      items = Item.search_order_by_item_name(@search_word)
      if items.empty?
        @orders = Order.order(created_at: "DESC").page(params[:page]).per(5)
      else 
        first_item = items.first
        first_orders = first_item.orders
        items.each do |item|
          if item != first_item
            first_orders = first_orders + item.orders
          end
        end
        @orders = Order.where(id: first_orders.map{ |order| order.id }).order(created_at: "DESC").page(params[:page]).per(5)
      end
    end
    @order_count = Order.count
    render 'orders_admin/index'
  end

  def show
    @order = Order.find(params[:order_id])
    render 'orders_admin/show'
  end

  def update
    
    @order = Order.find(params[:order_id])
    status_request_valid?(@order, params[:order_id])
    if ((params[:status] == '1' || params[:status] == '2') && (not params[:status].nil?))
      @order.update_attributes(status: params[:status].to_i)
      flash[:success] = "注文ステータスが更新されました"
      redirect_back(fallback_location: orders_admin_index_path)
    else
      flash[:warning] = "更新に失敗しました"
      redirect_back(fallback_location: orders_admin_index_path)
    end
  end

  private
    def admin?
      
      if session[:admin_id].nil?
        
        redirect_to root_url
      elsif Admin.find(session[:admin_id]).nil?
        redirect_to root_url
      end
    end

    def status_request_valid?(order, status)
      previous_status = order.status
      if previous_status > status.to_i
        redirect_to orders_admin_index_url
      end
    end
end
