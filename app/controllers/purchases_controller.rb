class PurchasesController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    render layout: "application_sub"
  end
end
