require 'test_helper'

class TipoCpmsControllerTest < ActionController::TestCase
  setup do
    @tipo_cpm = tipo_cpms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_cpms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_cpm" do
    assert_difference('TipoCpm.count') do
      post :create, tipo_cpm: { code: @tipo_cpm.code, name: @tipo_cpm.name }
    end

    assert_redirected_to tipo_cpm_path(assigns(:tipo_cpm))
  end

  test "should show tipo_cpm" do
    get :show, id: @tipo_cpm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_cpm
    assert_response :success
  end

  test "should update tipo_cpm" do
    patch :update, id: @tipo_cpm, tipo_cpm: { code: @tipo_cpm.code, name: @tipo_cpm.name }
    assert_redirected_to tipo_cpm_path(assigns(:tipo_cpm))
  end

  test "should destroy tipo_cpm" do
    assert_difference('TipoCpm.count', -1) do
      delete :destroy, id: @tipo_cpm
    end

    assert_redirected_to tipo_cpms_path
  end
end
