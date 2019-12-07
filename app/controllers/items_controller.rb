class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item,    only: [:show, :destroy, :edit, :update]

  def index
    @items = Item.order("id DESC").limit(10)
  end

  def new
    @item = Item.new
    @item.images.build
    render layout: "application_sub"
  end
  
  def create
    @item = Item.new(item_params)
    
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def show
    item = Item.find(params[:id])
    add_breadcrumb item.name
  end

  def edit
    @images = @item.images
    render layout: "application_sub"
  end

  def update
    if @item.update(update_item_params)
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

    params.require(:item).permit(
      :name,
      :explanation,
      :condition_id,
      :status_id,
      :shipping_method_id,
      :shipping_cost_id,
      :prefecture_id,
      :days_id,
      :price,
      :category_id,
      images_attributes:[:image]
      ).merge(user_id: current_user.id)
  end

  def update_item_params
    params.require(:item).permit(
      :name,
      :explanation,
      :condition_id,
      :status_id,
      :shipping_method_id,
      :shipping_cost_id,
      :prefecture_id,
      :days_id,
      :price,
      images_attributes:[:image, :_destroy, :id]
      ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
