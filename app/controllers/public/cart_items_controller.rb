class Public::CartItemsController < ApplicationController
    def index
        #@cart_items = current_customer.cart_items
        #あとカートの合計額を足したい
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
        redirect_to customers_cart_items_path
    end

    #全削除
    def destroy_all
        @cart_item = current_customer.cart_items
        @cart_item.destroy_all
        flash[:alert] = "カートの商品を全て削除しました"
        redirect_to customers_cart_items_path
    end

    def create
    end
    
    private

      def cart_item_params
        params.require(:cart_item).permit(:quantity, :item_id, :customer_id)
      end
    
end
