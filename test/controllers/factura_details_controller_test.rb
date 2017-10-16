require 'test_helper'

class FacturaDetailsControllerTest < ActionController::TestCase
  setup do
    @factura_detail = factura_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:factura_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create factura_detail" do
    assert_difference('FacturaDetail.count') do
      post :create, factura_detail: { contrato_cuota_id: @factura_detail.contrato_cuota_id, factura_id: @factura_detail.factura_id, moneda_id: @factura_detail.moneda_id, tipocambio: @factura_detail.tipocambio, total: @factura_detail.total }
    end

    assert_redirected_to factura_detail_path(assigns(:factura_detail))
  end

  test "should show factura_detail" do
    get :show, id: @factura_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @factura_detail
    assert_response :success
  end

  test "should update factura_detail" do
    patch :update, id: @factura_detail, factura_detail: { contrato_cuota_id: @factura_detail.contrato_cuota_id, factura_id: @factura_detail.factura_id, moneda_id: @factura_detail.moneda_id, tipocambio: @factura_detail.tipocambio, total: @factura_detail.total }
    assert_redirected_to factura_detail_path(assigns(:factura_detail))
  end

  test "should destroy factura_detail" do
    assert_difference('FacturaDetail.count', -1) do
      delete :destroy, id: @factura_detail
    end

    assert_redirected_to factura_details_path
  end
end
