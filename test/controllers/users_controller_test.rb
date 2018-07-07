require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { authy_id: @user.authy_id, country_code: @user.country_code, email: @user.email, name: @user.name, oauth_expires_at: @user.oauth_expires_at, oauth_token: @user.oauth_token, password_digest: @user.password_digest, phone: @user.phone, provider: @user.provider, uid: @user.uid, verified: @user.verified } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { authy_id: @user.authy_id, country_code: @user.country_code, email: @user.email, name: @user.name, oauth_expires_at: @user.oauth_expires_at, oauth_token: @user.oauth_token, password_digest: @user.password_digest, phone: @user.phone, provider: @user.provider, uid: @user.uid, verified: @user.verified } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
