class CreditsController < ApplicationController
  def index
    @credit = Credit.find_by(user_id: params[:user_id])
  end


  def destroy
    credit = Credit.find(params[:id])
    if credit.destroy
      redirect_to user_credits_path
    else
      render :index
    end
  end

  def new
    @credit = Credit.new
  end

  def create
    @credit = Credit.new(credit_params)
    @credit.valid?
    if @credit.errors.messages.blank? && @credit.errors.details.blank?
      if @credit.save
        redirect_to user_credits_path
      else
        render :new
      end
    else
      render :new
    end
  end

  private

  def credit_params
    params[:credit][:year] = Date.strptime(params[:credit]['date(1i)'], "%Y")
    params[:credit][:month] = Date.strptime(params[:credit]['date(2i)'], "%m")
    params.require(:credit).permit(:number, :year, :month, :security).merge(user_id: current_user.id)
  end

end
