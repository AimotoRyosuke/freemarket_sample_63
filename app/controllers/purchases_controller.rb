class PurchasesController < ApplicationController
  before_action :move_to_login

  def new
    @purchase = Purchase.new
    @item = Item.find(params[:item_id])
    @card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    if @card.blank?
    else
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
    render layout: "application_sub"
  end

  def create
    item = Item.find(params[:item_id])
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      if purchase = Purchase.create(purchase_params)
        item.status_id = 2
        item.save
        Payjp.api_key = ENV['PAYJP_SECRET_KEY']
        Payjp::Charge.create(
          amount: item.price,
          customer: card.customer_id,
          currency: 'jpy',
          )
        redirect_to action: 'done'
      else
        render :new
      end
    end
  end

  def done
    @item = Item.find(params[:item_id])
  end

  private

  def purchase_params
    params.permit().merge(user_id: current_user.id,item_id: params[:item_id])
  end

  def move_to_login
    redirect_to signin_path unless user_signed_in?
  end
  
end
