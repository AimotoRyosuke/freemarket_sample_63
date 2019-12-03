class ApplicationController < ActionController::Base

  before_action :basic_auth, if: :production?

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to signup_path, :notice => 'if you want to add a notice'
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
