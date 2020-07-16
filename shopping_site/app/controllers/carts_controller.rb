class CartsController < ApplicationController
    def index
        if logged_in_as_user?
            @carts = Cart.where(user_id: session[:user_id]).where(status: 0)
        else
            store_location
            redirect_to users_session_new_url
        end
    end

    def create
        if logged_in_as_user?
            @cart = Cart.new(user_id: session[:user_id], item_id: params[:item_id])

            if @cart.save
                flash[:notice] = 'カートに追加しました'
                redirect_to root_url
            else
                flash[:warning] = 'カートに追加できませんでした'
                redirect_to root_url
            end
        else
            store_location
            redirect_to users_session_new_url
        end
    end

    def destroy
        @cart = Cart.find(params[:id])
        @cart.destroy
        flash[:notice] = '削除されました'
        redirect_to carts_url
    end
    
end
