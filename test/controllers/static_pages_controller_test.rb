require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  def assert_title (title)
    assert_select 'title', "#{title} | Ruby on Rails Tutorial Sample App"
  end

  test 'should get home' do
    get :home
    assert_response :success
    assert_title 'Home'
  end

  test 'should get help' do
    get :help
    assert_response :success
    assert_title 'Help'
  end

  test 'should get about' do
    get :about
    assert_response :success
    assert_title 'About'
  end

  test 'should get contact' do
    get :contact
    assert_response :success
    assert_title 'Contact'
  end

end
