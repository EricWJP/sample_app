require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path,  params: { user: { name:  "",
                                          email: "user@invalid",
                                          password:              "foo",
                                          password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    # assert_select 'div#user_name', "name"
    # assert_select 'div.user[name]', "name"

  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    # assert is_logged_in?
  end

  # test "valid signup information" do
  #   get signup_path
  #   assert_difference 'User.count', 1 do
  #     post users_path, params: { user: { name:  "dtrfygvhbjknml",
  #                                        email: "usersdfg@example.com",
  #                                        password:              "password11",
  #                                        password_confirmation: "password11" } }
  #   end
  #   follow_redirect!
  #   assert_template 'users/show'
  #   assert is_logged_in?
  # end

end
