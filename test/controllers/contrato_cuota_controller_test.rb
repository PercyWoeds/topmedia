require 'test_helper'

class ContratoCuotaControllerTest < ActionController::TestCase
  setup do
    @contrato_cuotum = contrato_cuota(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contrato_cuota)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contrato_cuotum" do
    assert_difference('ContratoCuotum.count') do
      post :create, contrato_cuotum: { comision1: @contrato_cuotum.comision1, comision2: @contrato_cuotum.comision2, cuota: @contrato_cuotum.cuota, factura1: @contrato_cuotum.factura1, factura2: @contrato_cuotum.factura2, facturacanal: @contrato_cuotum.facturacanal, fecha: @contrato_cuotum.fecha, nro: @contrato_cuotum.nro, total: @contrato_cuotum.total, vventa: @contrato_cuotum.vventa }
    end

    assert_redirected_to contrato_cuotum_path(assigns(:contrato_cuotum))
  end

  test "should show contrato_cuotum" do
    get :show, id: @contrato_cuotum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contrato_cuotum
    assert_response :success
  end

  test "should update contrato_cuotum" do
    patch :update, id: @contrato_cuotum, contrato_cuotum: { comision1: @contrato_cuotum.comision1, comision2: @contrato_cuotum.comision2, cuota: @contrato_cuotum.cuota, factura1: @contrato_cuotum.factura1, factura2: @contrato_cuotum.factura2, facturacanal: @contrato_cuotum.facturacanal, fecha: @contrato_cuotum.fecha, nro: @contrato_cuotum.nro, total: @contrato_cuotum.total, vventa: @contrato_cuotum.vventa }
    assert_redirected_to contrato_cuotum_path(assigns(:contrato_cuotum))
  end

  test "should destroy contrato_cuotum" do
    assert_difference('ContratoCuotum.count', -1) do
      delete :destroy, id: @contrato_cuotum
    end

    assert_redirected_to contrato_cuota_path
  end
end
