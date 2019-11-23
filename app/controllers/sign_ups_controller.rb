class SignUpsController < ApplicationController

  def user_baseinfo
    @user = User.new
  end

  def user_baseinfo_validate

    session[:nickname]              = user_params[:nickname]
    session[:birth]                 = user_params[:birth]
    session[:email]                 = user_params[:email]
    session[:password]              = user_params[:password]
    session[:last_name]             = user_params[:last_name]
    session[:first_name]            = user_params[:first_name]
    session[:last_name_kana]        = user_params[:last_name_kana]
    session[:first_name_kana]       = user_params[:first_name_kana]

    @user = User.new(
      nickname:              session[:nickname],
      birth:                 session[:birth],
      email:                 session[:email],
      encrypted_password:    session[:password],
      last_name:             session[:last_name],
      first_name:            session[:first_name],
      last_name_kana:        session[:last_name_kana],
      first_name:            session[:first_name],
    )

    @user.valid?

    skip_tel_validate(@user.errors)

    if verify_recaptcha(model: @user, message: "選択してください") && @user.errors.messages.blank? && @user.errors.details.blank?
      redirect_to tel_signups_path
    else
      @user.errors.messages[:birth] = change_birthday_validate_message(@user)
      render :user_baseinfo
    end
  end

  def user_tel
    @user = User.new
  end

  def user_tel_validate

    session[:user_tel] = params[:user][:tel]

    @user = User.new(
      nickname:              session[:nickname],
      email:                 session[:email],
      encrypted_password:    session[:password],
      last_name:             session[:last_name],
      first_name:            session[:first_name],
      last_name_kana:        session[:last_name_kana],
      first_name:            session[:first_name],
      birth:                 session[:birth],
      tel:                   session[:tel],
    )

    @user.valid?

    if @user.errors.messages.blank? && @user.errors.details.blank?
      redirect_to auth_tel_signups_path
    else
      @user.errors.messages[:birth] = change_birthday_validate_message(@user)
      render :user_tel
    end
  end

  def user_tel_auth
  end

  def user_create
    if params[:user][:auth] == 1111
      @User.create(
        nickname:              session[:nickname],
        email:                 session[:email],
        encrypted_password:    session[:password],
        last_name:             session[:last_name],
        first_name:            session[:first_name],
        last_name_kana:        session[:last_name_kana],
        first_name:            session[:first_name],
        birth:                 session[:birth],
        tel:                   session[:tel],
      )
      sign_in User.find(@user.id) unless user_signed_in?
      session.delete[:nickname]
      session.delete[:birth]
      session.delete[:email]
      session.delete[:password]
      session.delete[:last_name]
      session.delete[:first_name]
      session.delete[:last_name_kana]
      session.delete[:first_name_kana]
      session.delete[:tel]

      redirect_to registrate_address_path
    else
      render user_tel_auth
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
      prefecture:      address_params[:prefecture],
      city:            address_params[:city],
      address:         address_params[:address],
      building:        address_params[:building],
      tel:             address_params[:tel],
    )

    @address.valid?

    skip_buildingandtel_validate(@user.errors)

    if @user.errors.messages.blank? && @user.errors.details.blank?
      redirect_to registrate_credit_path
    else
      @user.errors.messages[:birth] = change_birthday_validate_message(@user)
      render :user_address
    end

  end

  def user_credit
    @credit = Credit.new
  end
  
  def user_credit_create
      credit_validate

      redirect_to root_path
  end

  def credit_validate
    @credit = Credit.new(
      number:   credit_params[:number],
      year:     credit_params[:year],
      month:    credit_params[:month],
      security: credit_params[:security],
    )

    @credit.valid?

    if @user.errors.messages.blank? && @user.errors.details.blank?
      redirect_to address_signups_path
    else
      @user.errors.messages[:birth] = change_birthday_validate_message(@user)
      render :user_address
    end
  end

  private

  def user_params
    birth = Date.strptime("#{params[:user][:year]}" + "#{params[:user][:month]}" + "#{params[:user][:day]}", "%Y%m%d")
    params[:user][:birth] = birth
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :last_name, :first_name,
                                 :last_name_kana, :first_name, :birthday_year,
                                 :birthday_month, :birthday_day, :phonenumber)
  end

  def skip_tel_validate(errors)
    errors.messages.delete(:tel)
    errors.details.delete(:tel)
  end

  def change_birthday_validate_message(user)
    if user.errors.messages[:birthday_year].any? || user.errors.messages[:birthday_month].any? || user.errors.messages[:birthday_day].any?
      user.errors.messages.delete(:birthday)
      user.errors.messages.delete(:birthday_month)
      user.errors.messages[:birthday_year] = ["生年月日は正しく入力してください"]
      user.errors.messages[:birthday_year]
    end
  end

  def tel_params
    params.require(:user).permit(:tel)
  end

  def address_params
    params.require(:user).permit(:first_name, :last_name, :first_name_kana, :last_name, :tel)
  end

  def credit_params
    params.require(:credit).permit(:number, :name, :year, :month, :security)
  end
end
