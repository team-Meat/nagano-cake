class Public::SearchesController < ApplicationController

  def search
   @range = params[:range]

   if @range == "items"
      @items =Item.looks(params[:search],params[:word])

   end
  end
end
