class SignInController < ApplicationController
  before_action :authenticate_user!
  def signin
    @user = User.all
    render layout: "application_sub"
  end
end
