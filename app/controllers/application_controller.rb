class ApplicationController < ActionController::Base

  before_action :basic_auth, if: :production?
  add_breadcrumb "メルカリ", :root_path

  protected
  
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to signup_path
    end
  end

  def other_user!
    if current_user.id != params[:user_id]
      redirect_to root_path
    end
  end

  private

  def production?
    Rails.env.production?
  end


  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
