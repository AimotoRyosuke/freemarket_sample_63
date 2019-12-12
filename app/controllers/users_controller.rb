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

  def other_user!
    if params[:id] != current_user.id.to_s
      redirect_to root_path
    end
  end

  def SNS
    @google = SnsAuth.find_by('user_id = ? and provider = ?', current_user.id, 'google_oauth2')
    @facebook = SnsAuth.find_by('user_id = ? and provider = ?', current_user.id, 'facebook')
  end
  
  protected
  
  def update_resource(resource, params)
   resource.update_without_password(params)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :profile)
  end


end
