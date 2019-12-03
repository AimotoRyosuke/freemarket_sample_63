class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
  end

  def idetification
  end

  def logouts
  end

  def SNS
    @google = SnsAuth.find_by('user_id = ? and provider = ?', current_user.id, 'google_oauth2')
    @facebook = SnsAuth.find_by('user_id = ? and provider = ?', current_user.id, 'facebook')
  end

end
