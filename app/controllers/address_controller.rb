class AddressController < ApplicationController
  before_action :address_params, only: [:create, :update]
  before_action :other_user!
  add_breadcrumb "マイページ", :user_path
  add_breadcrumb "発送元・お届け先住所変更"

  def new
    if current_user.address.present?
      redirect_to edit_address_path(id: current_user.id)
    end
    @address = Address.new
  end
  
  def create
    address = Address.new(address_params)
    @address.valid?
    @address.tel = @address.tel.to_i
    if address.save
      redirect_to edit_address_path
    else
      render :new
    end
  end

  def edit
    @address = Address.find_by(user_id: params[:id])
  end

  def update
    unless Address.update(address_params)
      flash.now[:alert] = @skill.errors.full_messages
      render :edit and return
    end
    redirect_to edit_address_path
  end

  private

  def address_params
    unless  params[:address][:tel].match(/\A\d{10}$|^\d{11}\z/)
      params[:address][:tel] = ""
    end
    params.require(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :tel, :zip_code, :prefecture_id, :city, :address, :building, :tel).merge(user_id: current_user.id)
  end

  def other_user!
    if params[:id] != current_user.id.to_s
      redirect_to root_path
    end
  end

end