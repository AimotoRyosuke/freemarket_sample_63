class SignInController < ApplicationController
  def signin
    @user = User.all
  end
end
