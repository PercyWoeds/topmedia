require 'test_helper'

class TipoFormatosControllerTest < ActionController::TestCase
  setup do
    @tipo_formato = tipo_formatos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_formatos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_formato" do
    assert_difference('TipoFormato.count') do
      post :create, tipo_formato: { code: @tipo_formato.code, name: @tipo_formato.name }
    end

    assert_redirected_to tipo_formato_path(assigns(:tipo_formato))
  end

  test "should show tipo_formato" do
    get :show, id: @tipo_formato
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_formato
    assert_response :success
  end

  test "should update tipo_formato" do
    patch :update, id: @tipo_formato, tipo_formato: { code: @tipo_formato.code, name: @tipo_formato.name }
    assert_redirected_to tipo_formato_path(assigns(:tipo_formato))
  end

  test "should destroy tipo_formato" do
    assert_difference('TipoFormato.count', -1) do
      delete :destroy, id: @tipo_formato
    end

    assert_redirected_to tipo_formatos_path
  end
end
