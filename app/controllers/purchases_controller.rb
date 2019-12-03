class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card, only: [:new, :create]
  before_action :set_item

  def new
    @purchase = Purchase.new
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    if @card.blank?
    else
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
    render layout: "application_sub"
  end

  def create
    if @card.blank?
    else
      if purchase = Purchase.create(purchase_params)
        @item.status_id = 2
        @item.save
        Payjp.api_key = ENV['PAYJP_SECRET_KEY']
        Payjp::Charge.create(
          amount: @item.price,
          customer: @card.customer_id,
          currency: 'jpy',
          )
        redirect_to action: 'done'
      else
        render :new
      end
    end
  end

  def done
  end

  private

  def set_card
    @card = current_user.card
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.permit().merge(user_id: current_user.id,item_id: params[:item_id])
  end
  
end
