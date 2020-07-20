require 'test_helper'

class Users::DefControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_def_create_url
    assert_response :success
  end

end
