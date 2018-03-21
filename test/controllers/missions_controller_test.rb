require 'test_helper'

class MissionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # include devise helper methods
  def setup
    @admin = users(:admin)
    @user = users(:user)
    @user1 = users(:user_1)
    @mission1 = missions(:mission1)
    @mission2 = missions(:mission2)
  end

  test "only sign_in can access mission/index" do
    get missions_path
    assert_response :redirect


    sign_in @user

    get missions_path
    assert_response :success
  end

  #如果有副本正在進行中進去首頁會被導向任務頁面
  test "if user has instances will redirected to instances/index page when entering root" do
    # 有在打副本的成員
    sign_in @user

    get root_path
    assert_redirected_to instances_path

    # 目前沒有副本的成員
    sign_in @user1
    get root_path
    assert_redirected_to missions_path
  end

  test "only sign_in can access mission/show" do
    get mission_path(@mission1), xhr:true
    assert_response 401

    sign_in @user

    get mission_path(@mission1), xhr:true
    assert_response :success
  end

  test "user can initiate a mission instance" do
    # 等級不夠的使用者無法開啟副本
    sign_in @admin
    post challenge_mission_path(@mission2)
    assert_response :redirect
    assert_not flash[:alert].nil?

    # 等級夠的使用這可以開啟副本
    sign_in @user
    post challenge_mission_path(@mission2)
    assert_response :redirect
    assert_not flash[:notice].nil?
  end
end
