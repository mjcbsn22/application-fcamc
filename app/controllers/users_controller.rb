class UsersController < ApplicationController

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

  def user_params
    params[:user].permit :first_name, :last_name, :email, :password, :password_confirmation
  end

end
