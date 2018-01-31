class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    # binding.pry
    if @user && @user.authenticate(params[:session][:password])
      # 如果用户已激活就登入用户，然后重定向到用户的资料页面
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end


      # log_in @user
      # # remember @user
      # params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # redirect_back_or  @user
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
