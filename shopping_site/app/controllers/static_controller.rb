class StaticController < ApplicationController
  
  def Pages
  end

  def home
    @items = Item.page(params[:page]).per(20)
  end
end
