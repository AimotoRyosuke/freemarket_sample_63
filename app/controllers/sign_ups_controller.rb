class SignUpsController < ApplicationController
  require "payjp"
  before_action :authenticate_user!, except: [:signup_select, :user_baseinfo, :user_baseinfo_validate, :user_params, :user_tel, :user_tel_auth, :user_tel_validate, :user_create]
  before_action :user_params, only: :user_baseinfo_validate
  before_action :address_params, only: :user_address_create

  def signup_select
    render layout: "application_sub"
  end

  def user_baseinfo
    @user = User.new
    render layout: "application_sub"
  end

  def user_baseinfo_validate

    session[:nickname]              = user_params[:nickname]
    session[:birth]                 = user_params[:birth]
    session[:email]                 = user_params[:email]
    session[:password]              = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:first_name]            = user_params[:first_name]
    session[:last_name]             = user_params[:last_name]
    session[:first_name_kana]       = user_params[:first_name_kana]
    session[:last_name_kana]        = user_params[:last_name_kana]

    @user = User.new(
      nickname:              session[:nickname],
      birth:                 session[:birth],
      email:                 session[:email],
      password:              session[:password],
      password_confirmation: session[:password_confirmation],
      first_name:            session[:first_name],
      last_name:             session[:last_name],
      first_name_kana:       session[:first_name_kana],
      last_name_kana:        session[:last_name_kana],
    )

    @user.valid?
    change_birthday_validate_message(params)
    skip_tel_validate(@user.errors)

    if @user.errors.details == {} && @user.errors.messages == {}
       
      redirect_to signup_tel_path
    else
      render :user_baseinfo,layout: "application_sub"
    end
  end

  def user_tel
    if session[:nickname]
      @user = User.new
      render layout: "application_sub"
    else
      redirect_to signup_registration_path
    end
  end

  def user_tel_validate
    session[:tel] = params[:user][:tel]

    @user = User.new(
      nickname:              session[:nickname],
      birth:                 session[:birth],
      email:                 session[:email],
      password:              session[:password],
      password_confirmation: session[:password_confirmation],
      first_name:            session[:first_name],
      last_name:             session[:last_name],
      first_name_kana:       session[:first_name_kana],
      last_name_kana:        session[:last_name_kana],
      tel:                   session[:tel],
    )

    @user.valid?

    if @user.errors.details == {} && @user.errors.messages == {}
      redirect_to signup_tel_auth_path
    else
      render :user_tel, layout: "application_sub"
    end
  end

  def user_tel_auth
    if session[:tel]
      @user = User.new 
      render layout: "application_sub"
    else
      redirect_to signup_tel_path
    end
  end

  def user_create
    @user = User.new(
      nickname:              session[:nickname],
      birth:                 session[:birth],
      email:                 session[:email],
      password:              session[:password],
      password_confirmation: session[:password_confirmation],
      first_name:            session[:first_name],
      last_name:             session[:last_name],
      first_name_kana:       session[:first_name_kana],
      last_name_kana:        session[:last_name_kana],
      tel:                   session[:tel],
      )

    if params[:user][:auth].match(/\A[0-9]+\z/)
      if params[:user][:auth] == "111111"
        @user.save
        sign_in User.find(@user.id)
        session.delete(:nickname)
        session.delete(:birth)
        session.delete(:email)
        session.delete(:password)
        session.delete(:password_confirmation)
        session.delete(:first_name)
        session.delete(:last_name)
        session.delete(:first_name_kana)
        session.delete(:last_name_kana)
        session.delete(:tel)
        redirect_to registrate_address_path
      else
        @msg = "認証番号が一致しません"
        render :user_tel_auth, layout: "application_sub"
      end
    else  
      @msg = "認証番号を入力してください"
      render :user_tel_auth, layout: "application_sub"
    end
  end

  def user_address
    @address = Address.new
    render layout: "application_sub"
  end

  def user_address_create
    @address = Address.new(address_params)
    @address.valid?
    if @address.errors.messages == {} && @address.errors.details == {}
      @address.save
      redirect_to registrate_card_path
    else
      render :user_address, layout: "application_sub"
    end

  end

  def user_card
    @card = Card.new
    render layout: "application_sub"
  end
  
  def user_card_create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
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
        redirect_to action: "user_complete"
      else
        render :user_card, layout: "application_sub"
      end
    end
  end

  def user_complete
    render layout: "application_sub"
  end

  private

  def user_params
    if params[:birthday]['birthday(1i)'] != "" && params[:birthday]['birthday(2i)'] != "" && params[:birthday]['birthday(3i)'] != ""
      birth = params[:birthday]['birthday(1i)'] + "%02d" % params[:birthday]['birthday(2i)'] + "%02d" % params[:birthday]['birthday(3i)']
      params[:user][:birth] = birth 
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth, :tel)
    else
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth, :tel)
    end
  end

  def skip_tel_validate(errors)
    errors.messages.delete(:tel)
    errors.details.delete(:tel)
  end

  def change_birthday_validate_message(params)
    if params[:birthday]['birthday(1i)'] == "" && params[:birthday]['birthday(2i)'] == "" && params[:birthday]['birthday(3i)'] == ""
      @user.errors.messages[:birth] = ["生年月日を入力してください"]
    elsif params[:birthday]['birthday(1i)'] == "" || params[:birthday]['birthday(2i)'] == "" || params[:birthday]['birthday(3i)'] == ""
      @user.errors.messages[:birth] = ["生年月日を正しく入力してください"]
    else
      return
    end
  end

  def address_params
    unless  params[:address][:tel].match(/\A\d{10}$|^\d{11}\z/)
      params[:address][:tel] = ""
    end
    params.require(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :tel, :zip_code, :prefecture_id, :city, :address, :building, :tel).merge(user_id: current_user.id)
  end

  def card_params
    params[:card][:year] = Date.strptime(params[:card]['date(1i)'], "%Y")
    params[:card][:month] = Date.strptime(params[:card]['date(2i)'], "%m")
    params.require(:card).permit(:number, :year, :month, :security).merge(user_id: current_user.id)
  end
end
