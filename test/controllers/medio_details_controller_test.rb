require 'test_helper'

class MedioDetailsControllerTest < ActionController::TestCase
  setup do
    @medio_detail = medio_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:medio_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medio_detail" do
    assert_difference('MedioDetail.count') do
      post :create, medio_detail: { code: @medio_detail.code, medios_id: @medio_detail.medios_id, name: @medio_detail.name, user_id: @medio_detail.user_id }
    end

    assert_redirected_to medio_detail_path(assigns(:medio_detail))
  end

  test "should show medio_detail" do
    get :show, id: @medio_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @medio_detail
    assert_response :success
  end

  test "should update medio_detail" do
    patch :update, id: @medio_detail, medio_detail: { code: @medio_detail.code, medios_id: @medio_detail.medios_id, name: @medio_detail.name, user_id: @medio_detail.user_id }
    assert_redirected_to medio_detail_path(assigns(:medio_detail))
  end

  test "should destroy medio_detail" do
    assert_difference('MedioDetail.count', -1) do
      delete :destroy, id: @medio_detail
    end

    assert_redirected_to medio_details_path
  end
end
