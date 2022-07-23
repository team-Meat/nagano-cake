class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if params[:item][:price].present? && params[:item][:name].present? && params[:item][:explanation].present? && params[:item][:genre_id].present? && params[:item][:image].present?
      if params[:item][:price].to_s.ord >= 48 && params[:item][:price].to_s.ord <= 57
        if @item.save
          redirect_to admin_item_path(@item.id)
          flash[:success] = "登録しました"
        else
          flash[:danger] = "必要情報を入力してください"
          render "admin/items/new"
        end
      else
        flash[:danger] = "価格は半角数字で記入してください"
        redirect_to new_admin_item_path
      end
    else
      unless @item.save
        flash[:danger] = "必要情報を入力してください"
        render "admin/items/new"
      end
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
    if params[:item][:price].present? && params[:item][:name].present? && params[:item][:explanation].present? && params[:item][:genre_id].present? && params[:item][:image].present?
      if params[:item][:price].to_s.ord >= 48 && params[:item][:price].to_s.ord <= 57
        if @item.update(item_params)
          redirect_to admins_item_path(@item.id)
          flash[:success] = "更新しました"
        else
          flash[:danger] = "必要情報を入力してください"
          render "admin/items/edit"
        end
      else
        flash[:danger] = "価格は半角数字で記入してください"
        render "admin/items/edit"
      end
    else
      unless @product.update(product_params)
        flash[:danger] = "必要情報を入力してください"
        render "admin/items/edit"
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :image, :genre_id, :price, :is_enabled)
  end
end
