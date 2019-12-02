class UsersController < ApplicationController
  def show
  end

  def idetification
  end

  def logouts
  end

  def SNS
    @google = SnsAuth.where('user_id = ? and provider = ?', current_user.id, 'google_oauth2').first
    @facebook = SnsAuth.where('user_id = ? and provider = ?', current_user.id, 'facebook').first
  end

end
