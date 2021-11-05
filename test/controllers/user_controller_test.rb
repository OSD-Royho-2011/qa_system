require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get user_profile_url
    assert_response :success
  end

  test "should get setting" do
    get user_setting_url
    assert_response :success
  end

  test "should get edit" do
    get user_edit_url
    assert_response :success
  end
end
