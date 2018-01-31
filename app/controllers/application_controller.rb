class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :puts1
  before_action :puts2
  include SessionsHelper
  def hello
    render html: "hello, world!!"
  end

  private
  
  # 确保用户已登录
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def puts1
    # debugger
    console(12345678)
  end
  def puts2
    # breakpoint
    # debugger
    Rails.logger.info "fmewijjfwefkfefwkjwfwew"
    Rails.logger.debug("wangjinpeng ")
  end

end
