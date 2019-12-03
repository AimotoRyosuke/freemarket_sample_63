class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: 
  def new
  end
end
