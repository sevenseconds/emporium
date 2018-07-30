require 'test_helper'

class AboutControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get about_url
    assert_template 'about/index'
    assert_select 'title', 'About Emporium'
    assert_response :success
  end

end
