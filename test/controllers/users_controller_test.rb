require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get signup_url
    assert_response :success
    assert_select "title", full_title("Sign up");
  end

  # test "should get show" do
  #   get user_url(id: 1)
  #   assert_response :success
  #   # assert_select "title", full_title("用户详情");
  # end

end
