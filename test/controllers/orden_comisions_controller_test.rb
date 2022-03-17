require 'test_helper'

class OrdenComisionsControllerTest < ActionController::TestCase
  setup do
    @orden_comision = orden_comisions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orden_comisions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orden_comision" do
    assert_difference('OrdenComision.count') do
      post :create, orden_comision: { code: @orden_comision.code, name: @orden_comision.name }
    end

    assert_redirected_to orden_comision_path(assigns(:orden_comision))
  end

  test "should show orden_comision" do
    get :show, id: @orden_comision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @orden_comision
    assert_response :success
  end

  test "should update orden_comision" do
    patch :update, id: @orden_comision, orden_comision: { code: @orden_comision.code, name: @orden_comision.name }
    assert_redirected_to orden_comision_path(assigns(:orden_comision))
  end

  test "should destroy orden_comision" do
    assert_difference('OrdenComision.count', -1) do
      delete :destroy, id: @orden_comision
    end

    assert_redirected_to orden_comisions_path
  end
end
