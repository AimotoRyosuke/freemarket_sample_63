class UsersController < ApplicationController
  def show
  end

  def idetification
  end

  def logouts
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

  def address
  end
end
