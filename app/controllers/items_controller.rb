class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  def index
  end
<<<<<<< HEAD
  def new
  end
=======

>>>>>>> ec1d5cb4f2818ddcc1290563d81e7dbdc782f048
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
