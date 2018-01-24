class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # binding.pry
    @user = User.new(permitted_params)    # 不是最终的实现方式
    if @user.save
      flash[:success] = "Welcome to the sample App!"
      redirect_to @user
       # user_url(@user)
      # user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    # debugger
  end

  private
  def permitted_params
    # binding.pry
    params.require(:user).permit(User.attribute_names + [:password, :password_confirmation] - [:password_digest])
    # params.permit(user: User.attribute_names - [:password_digest])
  end
end