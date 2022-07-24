class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item =Item.new
  end

  def create
   @item = Item.new(item_params)
    if @item.save
     redirect_to admin_item_path(@item.id)
     flash[:success] = "商品を登録しました"
    else
     render "admin/items/new"
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
     redirect_to admin_item_path(@item.id)
     flash[:success] = "商品を更新しました"
    else
     render "admin/items/edit"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :image, :genre_id, :price, :is_enabled)
  end
end