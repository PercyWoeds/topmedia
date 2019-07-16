require 'test_helper'

class CustomerContratosControllerTest < ActionController::TestCase
  setup do
    @customer_contrato = customer_contratos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_contratos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_contrato" do
    assert_difference('CustomerContrato.count') do
      post :create, customer_contrato: { anio: @customer_contrato.anio, contrato_id: @customer_contrato.contrato_id, customer_id: @customer_contrato.customer_id, medio_id: @customer_contrato.medio_id, moneda_id: @customer_contrato.moneda_id, referencia: @customer_contrato.referencia, secu_org: @customer_contrato.secu_org }
    end

    assert_redirected_to customer_contrato_path(assigns(:customer_contrato))
  end

  test "should show customer_contrato" do
    get :show, id: @customer_contrato
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_contrato
    assert_response :success
  end

  test "should update customer_contrato" do
    patch :update, id: @customer_contrato, customer_contrato: { anio: @customer_contrato.anio, contrato_id: @customer_contrato.contrato_id, customer_id: @customer_contrato.customer_id, medio_id: @customer_contrato.medio_id, moneda_id: @customer_contrato.moneda_id, referencia: @customer_contrato.referencia, secu_org: @customer_contrato.secu_org }
    assert_redirected_to customer_contrato_path(assigns(:customer_contrato))
  end

  test "should destroy customer_contrato" do
    assert_difference('CustomerContrato.count', -1) do
      delete :destroy, id: @customer_contrato
    end

    assert_redirected_to customer_contratos_path
  end
end
