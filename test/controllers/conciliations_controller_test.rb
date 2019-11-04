require 'test_helper'

class ConciliationsControllerTest < ActionController::TestCase
  setup do
    @conciliation = conciliations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conciliations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conciliation" do
    assert_difference('Conciliation.count') do
      post :create, conciliation: { bank_acount_id: @conciliation.bank_acount_id, company_id: @conciliation.company_id, fecha1: @conciliation.fecha1, fecha2: @conciliation.fecha2, saldo_final: @conciliation.saldo_final, saldo_inicial: @conciliation.saldo_inicial, user_id: @conciliation.user_id }
    end

    assert_redirected_to conciliation_path(assigns(:conciliation))
  end

  test "should show conciliation" do
    get :show, id: @conciliation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conciliation
    assert_response :success
  end

  test "should update conciliation" do
    patch :update, id: @conciliation, conciliation: { bank_acount_id: @conciliation.bank_acount_id, company_id: @conciliation.company_id, fecha1: @conciliation.fecha1, fecha2: @conciliation.fecha2, saldo_final: @conciliation.saldo_final, saldo_inicial: @conciliation.saldo_inicial, user_id: @conciliation.user_id }
    assert_redirected_to conciliation_path(assigns(:conciliation))
  end

  test "should destroy conciliation" do
    assert_difference('Conciliation.count', -1) do
      delete :destroy, id: @conciliation
    end

    assert_redirected_to conciliations_path
  end
end
