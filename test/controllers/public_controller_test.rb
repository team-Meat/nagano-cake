require "test_helper"

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get name_addresses" do
    get public_name_addresses_url
    assert_response :success
  end
end
