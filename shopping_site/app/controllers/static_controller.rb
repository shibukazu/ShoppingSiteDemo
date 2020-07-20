class StaticController < ApplicationController
  
  def Pages
  end

  def home
    items = Item.search_by_name(params[:search])
    @search_word = params[:search]

    if params[:sort].nil?
      @items =  items.order(created_at: "DESC").page(params[:page]).per(20)
    else
      if params[:sort] == "1"
        @items = items.order(created_at: "DESC").page(params[:page]).per(20)
      elsif params[:sort] == "2"
        @items = items.order(created_at: "ASC").page(params[:page]).per(20)
      elsif params[:sort] == "3"
        @items = items.order(name: "ASC").page(params[:page]).per(20)
      else
        @items =  items.order(created_at: "DESC").page(params[:page]).per(20)
      end
    end
  end
end
