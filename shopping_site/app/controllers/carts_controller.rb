class CartsController < ApplicationController
    def index
        @carts = Cart.where(user_id: session[:user_id]).where(status: 0)
        
    end

    def create
        @cart = Cart.new(user_id: session[:user_id], item_id: params[:item_id])
        if @cart.save
            flash[:notice] = 'The item was successfully added to your cart'
            redirect_to root_url
        else
            flash[:warning] = 'カートに追加できませんでした'
            redirect_to root_url
        end
    end

    def destroy
        @cart = Cart.find(params[:id])
        @cart.destroy
        flash[:notice] = '削除されました'
        redirect_to carts_url
    end
    
end
