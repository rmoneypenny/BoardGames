require 'test_helper'

class SevenWondersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get seven_wonders_new_url
    assert_response :success
  end

end
