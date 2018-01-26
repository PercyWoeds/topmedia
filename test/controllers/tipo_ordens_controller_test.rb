require 'test_helper'

class TipoOrdensControllerTest < ActionController::TestCase
  setup do
    @tipo_orden = tipo_ordens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_ordens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_orden" do
    assert_difference('TipoOrden.count') do
      post :create, tipo_orden: { code: @tipo_orden.code, descrip: @tipo_orden.descrip }
    end

    assert_redirected_to tipo_orden_path(assigns(:tipo_orden))
  end

  test "should show tipo_orden" do
    get :show, id: @tipo_orden
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_orden
    assert_response :success
  end

  test "should update tipo_orden" do
    patch :update, id: @tipo_orden, tipo_orden: { code: @tipo_orden.code, descrip: @tipo_orden.descrip }
    assert_redirected_to tipo_orden_path(assigns(:tipo_orden))
  end

  test "should destroy tipo_orden" do
    assert_difference('TipoOrden.count', -1) do
      delete :destroy, id: @tipo_orden
    end

    assert_redirected_to tipo_ordens_path
  end
end
