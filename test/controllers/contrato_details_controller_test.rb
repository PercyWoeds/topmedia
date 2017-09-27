require 'test_helper'

class ContratoDetailsControllerTest < ActionController::TestCase
  setup do
    @contrato_detail = contrato_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contrato_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contrato_detail" do
    assert_difference('ContratoDetail.count') do
      post :create, contrato_detail: { comision1: @contrato_detail.comision1, comision2: @contrato_detail.comision2, factura1: @contrato_detail.factura1, factura2: @contrato_detail.factura2, facturacanal: @contrato_detail.facturacanal, fecha2: @contrato_detail.fecha2, fecha: @contrato_detail.fecha, importe: @contrato_detail.importe, nro: @contrato_detail.nro, total: @contrato_detail.total, vventa: @contrato_detail.vventa }
    end

    assert_redirected_to contrato_detail_path(assigns(:contrato_detail))
  end

  test "should show contrato_detail" do
    get :show, id: @contrato_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contrato_detail
    assert_response :success
  end

  test "should update contrato_detail" do
    patch :update, id: @contrato_detail, contrato_detail: { comision1: @contrato_detail.comision1, comision2: @contrato_detail.comision2, factura1: @contrato_detail.factura1, factura2: @contrato_detail.factura2, facturacanal: @contrato_detail.facturacanal, fecha2: @contrato_detail.fecha2, fecha: @contrato_detail.fecha, importe: @contrato_detail.importe, nro: @contrato_detail.nro, total: @contrato_detail.total, vventa: @contrato_detail.vventa }
    assert_redirected_to contrato_detail_path(assigns(:contrato_detail))
  end

  test "should destroy contrato_detail" do
    assert_difference('ContratoDetail.count', -1) do
      delete :destroy, id: @contrato_detail
    end

    assert_redirected_to contrato_details_path
  end
end
