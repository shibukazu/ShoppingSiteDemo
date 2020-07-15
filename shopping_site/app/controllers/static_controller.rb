class StaticController < ApplicationController
  def Pages
  end

  def home
    @items = Item.all()
  end
end
