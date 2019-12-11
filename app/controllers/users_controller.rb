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
    add_breadcrumb "ログイン"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user = User.find(params[:id])
      redirect_to "index"
    else
      render "edit"
    end
    params.permit(:nickname, :profile)
  end

  def other_user!
    if params[:id] != current_user.id.to_s
      redirect_to root_path
    end
  end

  def SNS
    @google = SnsAuth.find_by('user_id = ? and provider = ?', current_user.id, 'google_oauth2')
    @facebook = SnsAuth.find_by('user_id = ? and provider = ?', current_user.id, 'facebook')
  end

end
