class ItemsController < ApplicationController
        #before_action :set_admin, only: [:show, :edit, :update, :destroy]
        before_action :admin?, only: [:index, :new, :create, :destroy, :edit, :update]

        # GET /admins
        # GET /admins.json
        def index
            items = Item.search_by_name(params[:search])
            @search_word = params[:search]
            if params[:sort].nil?
                @items = items.order(updated_at: "DESC").page(params[:page]).per(10)
            else
                if params[:sort] == "1"
                    @items = items.order(created_at: "DESC").page(params[:page]).per(10)
                elsif params[:sort] == "2"
                    @items = items.order(created_at: "ASC").page(params[:page]).per(10)
                elsif params[:sort] == "3"
                    @items = items.order(name: "ASC").page(params[:page]).per(10)
                elsif params[:sort] == "4"
                    @items = items.order(updated_at: "DESC").page(params[:page]).per(10)
                else
                    @items = items.order(updated_at: "DESC").page(params[:page]).per(10)
                end
            end
        end

        # GET /admins/new
        def new
            @item = Item.new
        end

        def show
            @item = Item.find(params[:id])
        end
        
        def edit
            @item = Item.find(params[:id])
        end

        def update
            @item = Item.find(params[:id])
            if @item.update_attributes(item_params)
                flash[:success] = "商品は正常に更新されました"
                redirect_to items_url
            
            else
                redirect_to edit_item_url, flash: { error: @item.errors.full_messages,
                                                    info: { name: @item.name,
                                                        price: @item.price,
                                                        image: @item.image.url } }
            end
        end
        # POST /admins
        # POST /admins.json
        def create
            @item = Item.new(item_params)
            if @item.save
                flash[:success] = '商品は正常に登録されました' 
                redirect_to items_url
            else
                redirect_to new_item_url, flash: { error: @item.errors.full_messages,
                                                info: { name: @item.name,
                                                        price: @item.price,
                                                        image: @item.image.url } }

            end
        end
        
      
        def destroy
            @item = Item.find(params[:id]).destroy
            redirect_to items_url
            flash[:success] = '商品は正常に削除されました'
        end
      
        private
          # Only allow a list of trusted parameters through.
            def item_params
                params.require(:item).permit(:name, :price, :image)
            end
      
            def admin?
                if session[:admin_id].nil?
                    redirect_to root_url
                elsif Admin.find(session[:admin_id]).nil?
                    redirect_to root_url
                end
            end
end