class CartsController < ApplicationController
    def index
        if logged_in_as_user?
            if session[:item_id].nil?
                @carts = Cart.where(user_id: session[:user_id]).where(status: 0)
            else
                @cart = Cart.new(user_id: session[:user_id], item_id: session[:item_id])
                session.delete(:item_id)
                if @cart.save
                    flash[:success] = 'カートに追加しました'
                    redirect_to carts_url
                else
                    flash[:warning] = 'カートに追加できませんでした'
                    redirect_to root_url
                end
            end
        else
            store_location
            redirect_to users_session_new_url
        end
    end

    def create
        if logged_in_as_user?
            @cart = Cart.new(user_id: session[:user_id], item_id: params[:item_id])
            store_location
            if @cart.save
                flash[:success] = 'カートに追加しました'
                redirect_back_or(root_url)
            else
                flash[:warning] = 'カートに追加できませんでした'
                redirect_back_or(root_url)
            end
        else
            store_location
            session[:item_id] = params[:item_id]
            redirect_to users_session_new_url
        end
    end

    def destroy
        @cart = Cart.find(params[:id])
        flash[:success] = "カートから#{@cart.item.name}は削除されました"
        @cart.destroy
        redirect_to carts_url
    end
    
end
