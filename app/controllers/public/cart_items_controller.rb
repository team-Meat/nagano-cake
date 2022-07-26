class Public::CartItemsController < ApplicationController
    def index
        @cart_items = CartItem.all
        #カートの合計額を足したい
        @total_price = @cart_items.sum(&:subtotal)
    end
    
    # 削除や個数を変更した際にカート商品を再計算
    def update
        @cart_item = CartItem.find(params[:id])
        @cart_item.update(cart_item_params)
        redirect_to customers_cart_items_path
    end

    #一部削除
    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        flash.now[:alert] = "#{@cart_item.item.name}を削除しました"
        redirect_to cart_items_path
    end

    #全削除
    def destroy_all
        @cart_item = current_customer.cart_items
        @cart_item.destroy_all
        flash[:alert] = "カートの商品を全て削除しました"
        redirect_to customers_path
    end

    def create
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.customer_id = current_customer.id
        @cart_item.item_id = cart_item_params[:item_id]
        @item = Item.find(cart_item_params[:item_id])
        
        if @cart_item.save
          flash[:notice] = "#{@cart_item.item.name}をカートに追加しました"
            redirect_to cart_items_path
        else
            flash[:alert] = "個数を選択してください"
            render "public/items/show"
        end
    end
    
    private

      def cart_item_params
        params.require(:cart_item).permit(:quantity, :item_id, :customer_id)
      end
    
end
