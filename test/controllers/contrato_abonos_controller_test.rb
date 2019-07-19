require 'test_helper'

class ContratoAbonosControllerTest < ActionController::TestCase
  setup do
    @contrato_abono = contrato_abonos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contrato_abonos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contrato_abono" do
    assert_difference('ContratoAbono.count') do
      post :create, contrato_abono: { customer_id: @contrato_abono.customer_id, fecha: @contrato_abono.fecha, importe: @contrato_abono.importe, medio_id: @contrato_abono.medio_id, moneda_id: @contrato_abono.moneda_id, observa: @contrato_abono.observa, secu_cont: @contrato_abono.secu_cont }
    end

    assert_redirected_to contrato_abono_path(assigns(:contrato_abono))
  end

  test "should show contrato_abono" do
    get :show, id: @contrato_abono
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contrato_abono
    assert_response :success
  end

  test "should update contrato_abono" do
    patch :update, id: @contrato_abono, contrato_abono: { customer_id: @contrato_abono.customer_id, fecha: @contrato_abono.fecha, importe: @contrato_abono.importe, medio_id: @contrato_abono.medio_id, moneda_id: @contrato_abono.moneda_id, observa: @contrato_abono.observa, secu_cont: @contrato_abono.secu_cont }
    assert_redirected_to contrato_abono_path(assigns(:contrato_abono))
  end

  test "should destroy contrato_abono" do
    assert_difference('ContratoAbono.count', -1) do
      delete :destroy, id: @contrato_abono
    end

    assert_redirected_to contrato_abonos_path
  end
end
