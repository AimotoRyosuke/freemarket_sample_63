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
  end

  def search
    @items = Item.search(params[:keyword]).page(params[:page]).per(2).order("created_at DESC")
    @keyword = params[:keyword]
  end

  def mid_category
    @mid_category = Category.find_all_by_generation(1).with_ancestor(params[:large_category]).order(id: :asc).to_a
    respond_to do |format|
      format.json {@mid_category}
    end
  end

  def small_category
    @small_category = Category.find_all_by_generation(2).with_ancestor(params[:mid_category]).order(id: :asc).to_a
    respond_to do |format|
      format.json {@small_category}
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :explanation, :condition_id, :status_id, :shipping_method_id, :shipping_cost_id, :prefecture_id, :days_id, :price, :category_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
