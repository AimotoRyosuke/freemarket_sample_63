class SignInController < ApplicationController
  def signin
    @user = User.all
    render layout: false
  end
end
