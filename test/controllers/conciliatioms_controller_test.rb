require 'test_helper'

class ConciliatiomsControllerTest < ActionController::TestCase
  setup do
    @conciliatiom = conciliatioms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conciliatioms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conciliatiom" do
    assert_difference('Conciliatiom.count') do
      post :create, conciliatiom: { bank_acount_id: @conciliatiom.bank_acount_id, company_id: @conciliatiom.company_id, fecha1: @conciliatiom.fecha1, fecha2: @conciliatiom.fecha2, saldo_final: @conciliatiom.saldo_final, saldo_inicial: @conciliatiom.saldo_inicial, user_id: @conciliatiom.user_id }
    end

    assert_redirected_to conciliatiom_path(assigns(:conciliatiom))
  end

  test "should show conciliatiom" do
    get :show, id: @conciliatiom
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conciliatiom
    assert_response :success
  end

  test "should update conciliatiom" do
    patch :update, id: @conciliatiom, conciliatiom: { bank_acount_id: @conciliatiom.bank_acount_id, company_id: @conciliatiom.company_id, fecha1: @conciliatiom.fecha1, fecha2: @conciliatiom.fecha2, saldo_final: @conciliatiom.saldo_final, saldo_inicial: @conciliatiom.saldo_inicial, user_id: @conciliatiom.user_id }
    assert_redirected_to conciliatiom_path(assigns(:conciliatiom))
  end

  test "should destroy conciliatiom" do
    assert_difference('Conciliatiom.count', -1) do
      delete :destroy, id: @conciliatiom
    end

    assert_redirected_to conciliatioms_path
  end
end
