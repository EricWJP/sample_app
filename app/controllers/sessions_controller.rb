class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    # binding.pry
    if @user && @user.authenticate(params[:session][:password])
      # 登入用户，然后重定向到用户的资料页面
      log_in @user
      remember @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = "Invalide email/password combination"
      render 'new'
    end
  end

  def destroy
    # forget current_user
    log_out
    redirect_to root_url
  end
end
