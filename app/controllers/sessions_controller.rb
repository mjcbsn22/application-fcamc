class SessionsController < ApplicationController

  skip_before_filter :require_login, :except => [:destroy]

  def new
    logout if logged_in?
    @user = User.new
  end

  def create
    if @user = login(params[:user][:email], params[:user][:password], params[:remember_me])
      redirect_to(root_path, notice: 'Login successful.')
    else
      redirect_to(root_path, alert: 'Login failed!')
    end
  end

  def destroy
    logout if logged_in?
    redirect_to(root_path, notice: 'Logged out!')
  end

end
