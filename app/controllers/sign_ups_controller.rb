class SignUpsController < ApplicationController
  before_action :user_params, only: :user_baseinfo_validate
  before_action :address_params, only: :user_address_create 
  before_action :credit_params, only: :user_credit_create

  def user_baseinfo
    @user = User.new
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
      encrypted_password:    session[:password],
      # password_confirmation: session[:password_confirmation],
      first_name:            session[:first_name],
      last_name:             session[:last_name],
      first_name_kana:       session[:first_name_kana],
      last_name_kana:        session[:last_name_kana],
    )
    @user.valid?

    skip_tel_validate(@user.errors)
    binding.pry
    if @user.errors 
      render :user_baseinfo
    else
      redirect_to signup_tel_path
    end
  end

  def user_tel
    @user = User.new
  end

  def user_tel_validate
    session[:tel] = params[:user][:tel]

    @user = User.create(
      nickname:              session[:nickname],
      email:                 session[:email],
      password:              session[:password],
      password_confirmation: session[:password_confirmation],
      first_name:            session[:first_name],
      last_name:             session[:last_name],
      first_name_kana:       session[:first_name_kana],
      last_name_kana:        session[:last_name_kana],
      birth:                 session[:birth],
      tel:                   session[:tel],
    )

    @user.valid?

    if true
      # @user.errors.messages.blank? && @user.errors.details.blank?
      redirect_to signup_tel_auth_path
    else
      @user.errors.messages[:birth] = change_birthday_validate_message(@user)
      render :user_tel
    end
  end

  def user_tel_auth
    @user = User.new
  end

  def user_create
    if params[:user][:auth] == "111111"
      @user = User.create(
        nickname:              session[:nickname],
        email:                 session[:email],
        password:              session[:password],
        password_confirmation: session[:password_confirmation],
        first_name:            session[:first_name],
        last_name:             session[:last_name],
        first_name_kana:       session[:first_name_kana],
        last_name_kana:        session[:last_name_kana],
        birth:                 session[:birth],
        tel:                   session[:tel],
        )

        # sign_in User.find(@user.id) unless user_signed_in?
          session.delete(:nickname)
          session.delete(:birth)
          session.delete(:email)
          session.delete(:password)
          session.delete(:first_name)
          session.delete(:last_name)
          session.delete(:first_name_kana)
          session.delete(:last_name_kana)
          session.delete(:tel)
          redirect_to registrate_address_path
    else
      render :user_tel_auth
    end
  end

  def user_address
    @address = Address.new
  end

  def user_address_create
    @address = Address.new(
      first_name:      address_params[:first_name],
      last_name:       address_params[:last_name],
      first_name_kana: address_params[:first_name_kana],
      last_name_kana:  address_params[:last_name_kana],
      zip_code:        address_params[:zip_code],
      prefecture_id:   address_params[:prefecture_id],
      city:            address_params[:city],
      address:         address_params[:address],
      building:        address_params[:building],
      tel:             address_params[:tel],
      user_id:         address_params[:user_id]
    )

    @address.save
    @address.valid?

    if @address.errors.messages.blank? && @address.errors.details.blank?
      redirect_to registrate_credit_path
    else
      # @user.errors.messages[:birth] = change_birthday_validate_message(@user)
      render :user_address
    end

  end

  def user_credit
    @credit = Credit.new
  end
  
  def user_credit_create
      credit_validate
      @credit.save
      redirect_to root_path
  end

  def credit_validate
    @credit = Credit.new(
      number:   credit_params[:number],
      year:     credit_params[:year],
      month:    credit_params[:month],
      security: credit_params[:security],
      user_id:  credit_params[:user_id]
    )
    @credit.valid?

    if @credit.errors.messages.blank? && @credit.errors.details.blank?
      return @credit
    else
      # @user.errors.messages[:birth] = change_birthday_validate_message(@user)
      render :user_credit
    end
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

  def address_params
    params.require(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :tel, :zip_code, :prefecture_id, :city, :address, :building, :tel).merge(user_id: current_user.id)
  end

  def credit_params
    params[:credit][:year] = Date.strptime(params[:credit]['date(1i)'], "%Y")
    params[:credit][:month] = Date.strptime(params[:credit]['date(2i)'], "%m")
    params.require(:credit).permit(:number, :year, :month, :security).merge(user_id: current_user.id)
  end
end
