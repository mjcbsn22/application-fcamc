class UsersController < ApplicationController
  before_action :get_user, only: :show

  def index
    @users = User.includes(:roles).where(member_state: [:active, :inactive])
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params[:user].permit(:first_name, :last_name, :email)
  end

end
