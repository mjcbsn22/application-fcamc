class UsersController < ApplicationController
before_action :get_user, only: :show

  def index
    @users = User.includes(:roles).where(member_state: [:active, :inactive])
  end

  def new
  end

  def create
    user = User.new user_params

    if user.save
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Login successful.'
    else
      flash.now[:error] = object_errors_flash user
      render 'welcome/index'
    end
  end

  private

  def get_user
    @user = User.find params[:id]
  end

  def user_params
    params[:user].permit :first_name, :last_name, :email, :password, :password_confirmation
  end

end
