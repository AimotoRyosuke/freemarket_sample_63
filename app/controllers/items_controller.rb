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
    @category = Category.find(item.category_id)
    add_breadcrumb item.name
  end

  def edit
    if @item.user.id == current_user.id
      @images = @item.images
      @category = Category.find(@item.category_id)
      render layout: "application_sub"
    else
      redirect_to root_path
    end
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
    binding.pry
    if params[:category].present?
      add_breadcrumb "カテゴリー一覧", category_items_path
      @items = Item.cat_search(params[:category]).page(params[:page]).per(100).order("created_at DESC")
      @category = Category.find(params[:category])
      if @category.root?
        add_breadcrumb @category.root.name
      else
        add_breadcrumb @category.root.name if @category.parent.parent
        add_breadcrumb @category.parent.name if @category.parent
        add_breadcrumb @category.name
      end
    else
      redirect_to category_items_path
    end
  end

  def search
    unless params[:item]
      params[:item] = {}
    end
    unless params[:condition_id]
      params[:condition_id] = [""]
      params[:status_id] = [""]
      params[:shipping_cost_id] = [""]
      params[:item_large_id] = ""
      params[:minprice] = ""
      params[:maxprice] = ""
    end
    @items = Item.search(params[:keyword], params[:condition_id], params[:shipping_cost_id], params[:status_id], params[:minprice], params[:maxprice], params[:item_large_id], params[:item][:mid_id], params[:item][:category_id]).page(params[:page]).limit(100).per(100).order("created_at DESC")
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

  def category_index
    @category = Category.all
    add_breadcrumb "カテゴリー一覧"
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

  # def　search_params
  #   params[:keyword],
  #   params[:condition_id],
  #   params[:shipping_cost_id],
  #   params[:status_id],
  #   params[:minprice],
  #   params[:maxprice],
  #   params[:item_large_id],
  #   params[:item][:mid_id],
  #   params[:item][:category_id]
  # end

  def set_item
    @item = Item.find(params[:id])
  end
end
