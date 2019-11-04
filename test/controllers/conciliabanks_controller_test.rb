require 'test_helper'

class ConciliabanksControllerTest < ActionController::TestCase
  setup do
    @conciliabank = conciliabanks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conciliabanks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conciliabank" do
    assert_difference('Conciliabank.count') do
      post :create, conciliabank: { bank_acount_id: @conciliabank.bank_acount_id, company_id: @conciliabank.company_id, fecha1: @conciliabank.fecha1, fecha2: @conciliabank.fecha2, saldo_final: @conciliabank.saldo_final, saldo_inicial: @conciliabank.saldo_inicial, user_id: @conciliabank.user_id }
    end

    assert_redirected_to conciliabank_path(assigns(:conciliabank))
  end

  test "should show conciliabank" do
    get :show, id: @conciliabank
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conciliabank
    assert_response :success
  end

  test "should update conciliabank" do
    patch :update, id: @conciliabank, conciliabank: { bank_acount_id: @conciliabank.bank_acount_id, company_id: @conciliabank.company_id, fecha1: @conciliabank.fecha1, fecha2: @conciliabank.fecha2, saldo_final: @conciliabank.saldo_final, saldo_inicial: @conciliabank.saldo_inicial, user_id: @conciliabank.user_id }
    assert_redirected_to conciliabank_path(assigns(:conciliabank))
  end

  test "should destroy conciliabank" do
    assert_difference('Conciliabank.count', -1) do
      delete :destroy, id: @conciliabank
    end

    assert_redirected_to conciliabanks_path
  end
end
