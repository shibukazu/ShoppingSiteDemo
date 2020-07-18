class StaticController < ApplicationController
  
  def Pages
  end

  def home
    
    if params[:sort].nil?
      @items = Item.order(name: "ASC").page(params[:page]).per(20)
    else
      if params[:sort] == "1"
        @items = Item.order(created_at: "DESC").page(params[:page]).per(20)
      elsif params[:sort] == "2"
        @items = Item.order(created_at: "ASC").page(params[:page]).per(20)
      else
        @items = Item.order(name: "ASC").page(params[:page]).per(20)
      end
    end
  end
end
