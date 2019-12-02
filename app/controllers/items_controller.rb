class ItemsController < ApplicationController
  before_action :set_item,    only: [:show, :destroy, :edit, :update]
  before_action :item_params, only: :update

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    render layout: "application_sub"
  end
  
  def create
    item = Item.new(item_params)
    if item.save
      redirect_to item_path(item)
    else
      render :new
    end
  end

  def show
  end

  def edit
    render layout: "application_sub"
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :explanation, :condition_id, :status_id, :shipping_method_id, :shipping_cost_id, :prefecture_id, :days_id, :price).merge(user_id: current_user.id)
  end
  def set_item
    @item = Item.find(params[:id])
  end
end
