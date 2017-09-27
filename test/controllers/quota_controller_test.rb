require 'test_helper'

class QuotaControllerTest < ActionController::TestCase
  setup do
    @quotum = quota(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quota)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quotum" do
    assert_difference('Quotum.count') do
      post :create, quotum: { comision1: @quotum.comision1, comision2: @quotum.comision2, factura1: @quotum.factura1, factura2: @quotum.factura2, facturacanal: @quotum.facturacanal, fecha2: @quotum.fecha2, fecha: @quotum.fecha, importe: @quotum.importe, nro: @quotum.nro, total: @quotum.total, vventa: @quotum.vventa }
    end

    assert_redirected_to quotum_path(assigns(:quotum))
  end

  test "should show quotum" do
    get :show, id: @quotum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quotum
    assert_response :success
  end

  test "should update quotum" do
    patch :update, id: @quotum, quotum: { comision1: @quotum.comision1, comision2: @quotum.comision2, factura1: @quotum.factura1, factura2: @quotum.factura2, facturacanal: @quotum.facturacanal, fecha2: @quotum.fecha2, fecha: @quotum.fecha, importe: @quotum.importe, nro: @quotum.nro, total: @quotum.total, vventa: @quotum.vventa }
    assert_redirected_to quotum_path(assigns(:quotum))
  end

  test "should destroy quotum" do
    assert_difference('Quotum.count', -1) do
      delete :destroy, id: @quotum
    end

    assert_redirected_to quota_path
  end
end
