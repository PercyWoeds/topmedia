require 'test_helper'

class TipoAvisosControllerTest < ActionController::TestCase
  setup do
    @tipo_aviso = tipo_avisos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_avisos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_aviso" do
    assert_difference('TipoAviso.count') do
      post :create, tipo_aviso: { code: @tipo_aviso.code, name: @tipo_aviso.name, user_id: @tipo_aviso.user_id }
    end

    assert_redirected_to tipo_aviso_path(assigns(:tipo_aviso))
  end

  test "should show tipo_aviso" do
    get :show, id: @tipo_aviso
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_aviso
    assert_response :success
  end

  test "should update tipo_aviso" do
    patch :update, id: @tipo_aviso, tipo_aviso: { code: @tipo_aviso.code, name: @tipo_aviso.name, user_id: @tipo_aviso.user_id }
    assert_redirected_to tipo_aviso_path(assigns(:tipo_aviso))
  end

  test "should destroy tipo_aviso" do
    assert_difference('TipoAviso.count', -1) do
      delete :destroy, id: @tipo_aviso
    end

    assert_redirected_to tipo_avisos_path
  end
end
