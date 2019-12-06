class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item,    only: [:show, :destroy, :edit, :update]
  before_action :item_params, only: :update

  def index
    @items = Item.order("id DESC").limit(10)
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
    item = Item.find(params[:id])
    add_breadcrumb item.name
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

  def category_search
    @items = Item.all.page(params[:page]).per(2).order("created_at DESC")
    add_breadcrumb "カテゴリー一覧", root_path
    add_breadcrumb "カテゴリー大"
    add_breadcrumb "カテゴリー中"
    add_breadcrumb "カテゴリー小"
  end

  def search
    @items = Item.search(params[:keyword]).page(params[:page]).limit(100).per(100).order("created_at DESC")
    @no_items = Item.all.order("created_at DESC").limit(100)
    @keyword = params[:keyword]
    add_breadcrumb @keyword if @keyword != ""
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :explanation, :condition_id, :status_id, :shipping_method_id, :shipping_cost_id, :prefecture_id, :days_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
