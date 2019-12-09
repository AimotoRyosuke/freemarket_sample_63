class SignInController < ApplicationController
  def signin
    @user = User.all
    render layout: "application_sub"
  end
end
