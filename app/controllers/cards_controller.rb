class CardsController < ApplicationController

  require "payjp"

  def new
    @card = Card.new
    @card.valid?
    card = Card.find_by(user_id: current_user.id)
    redirect_to action: "index" if card.present?
  end
  
  def create
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: 'メルカリテスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def destroy 
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
    redirect_to action: "new"
  end
  
  def index
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

end
