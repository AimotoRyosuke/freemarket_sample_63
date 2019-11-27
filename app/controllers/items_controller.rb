class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  def index
  end

  def new
  end

  def show
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end
  
  private

  def set_item
    @item = Item.find(params[:id])
  end
end
