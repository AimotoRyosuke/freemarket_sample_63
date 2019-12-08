class CardsController < ApplicationController
  before_action :set_card, only: [:destroy, :index]

  require "Payjp"

  def new
    @card = Card.new
    @card.valid?
    card = current_user.card
    redirect_to action: "index" if card.present?
  end
  
  def create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      binding.pry
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
    if @card.blank?
    else
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
    redirect_to action: "new"
  end
  
  def index
    
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  private
  def set_card
    @card = current_user.card
  end

end
