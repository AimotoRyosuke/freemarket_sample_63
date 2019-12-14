class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :other_user!
  add_breadcrumb "マイページ", :user_path
  
  def show
  end

  def idetification
    add_breadcrumb "本人情報の登録"
  end

  def logouts
    add_breadcrumb "ログアウト"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def other_user!
    if params[:id] != current_user.id.to_s
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:nickname, :profile)
  end

end
