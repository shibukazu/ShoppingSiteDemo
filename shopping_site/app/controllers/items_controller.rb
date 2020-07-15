class ItemsController < ApplicationController
        #before_action :set_admin, only: [:show, :edit, :update, :destroy]
        before_action :admin?, only: [:index, :new, :create, :destroy, :edit, :update]

        # GET /admins
        # GET /admins.json
        def index
            @items = Item.all.order(updated_at: "DESC")
        end

        # GET /admins/new
        def new
            @item = Item.new
        end
        
        def edit
            @item = Item.find(params[:id])
        end

        def update
            @item = Item.find(params[:id])
            if @item.update_attributes(item_params)
                flash[:success] = "Item information updated successfully"
                redirect_to items_url
            
            else
                render 'edit'
            end
        end
        # POST /admins
        # POST /admins.json
        def create
            @item = Item.new(item_params)
            if @item.save
                flash[:notice] = 'Item was successfully saved.' 
                redirect_to items_url
            else
                render :new 
            end
        end
        
      
        def destroy
            @item = Item.find(params[:id]).destroy
            redirect_to items_url
            flash[:notice] = 'Item was successfully destroyed.'
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