class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: params[:per_page])
    # binding.pry
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    # binding.pry
    @user = User.new(permitted_params)    # 不是最终的实现方式
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url

      # flash[:success] = "Welcome to the sample App!"
      # redirect_to @user
       # user_url(@user)
      # user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(permitted_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    flash[:success] = "#{user.name} has been deleted"
    user.destroy
    redirect_to users_path
  end

  private

  #健壮参数
  def permitted_params
    # binding.pry
    params.require(:user).permit(User.attribute_names.map(&:to_sym) + [:password, :password_confirmation] - [:password_digest, :admin])
    # params.permit(user: User.attribute_names - [:password_digest])
  end

  #确保用户已登录
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please sign in."
      redirect_to login_path
    end
  end

  # 确保是正确的用户
  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url  unless current_user?(@user)
  end

  # 确保是管理员
  def admin_user
    redirect_to root_url  unless current_user.admin?
  end


end