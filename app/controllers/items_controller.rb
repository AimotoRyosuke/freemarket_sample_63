class ItemsController < ApplicationController
  def index
  end
  def show
    @item = Item.find(params[:id])
  end
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end
end
