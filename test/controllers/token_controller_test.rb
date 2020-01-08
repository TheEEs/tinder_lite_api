require 'test_helper'

class TokenControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get token_add_url
    assert_response :success
  end

  test "should get remove" do
    get token_remove_url
    assert_response :success
  end

end
