require 'test_helper'

class Admins::ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admins_contacts_new_url
    assert_response :success
  end

  test "should get create" do
    get admins_contacts_create_url
    assert_response :success
  end

end
