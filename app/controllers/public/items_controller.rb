class Public::ItemsController < ApplicationController

  def index
     # ページネーションをつけたいデータに.page(params[:page])を追加.https://qiita.com/rio_threehouse/items/313824b90a31268b0074
    @items = Item.all.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private
  def item_params
  	  params.require(:item).permit(:genre_id, :name, :price, :explanation)
  end
end

