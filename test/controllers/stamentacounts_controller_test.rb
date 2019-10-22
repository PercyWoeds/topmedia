require 'test_helper'

class StamentacountsControllerTest < ActionController::TestCase
  setup do
    @stamentacount = stamentacounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stamentacounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stamentacount" do
    assert_difference('Stamentacount.count') do
      post :create, stamentacount: { bank_account_id: @stamentacount.bank_account_id, company_id: @stamentacount.company_id, fecha1: @stamentacount.fecha1, fecha2: @stamentacount.fecha2, saldo_final: @stamentacount.saldo_final, saldo_inicial: @stamentacount.saldo_inicial, user_id: @stamentacount.user_id }
    end

    assert_redirected_to stamentacount_path(assigns(:stamentacount))
  end

  test "should show stamentacount" do
    get :show, id: @stamentacount
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stamentacount
    assert_response :success
  end

  test "should update stamentacount" do
    patch :update, id: @stamentacount, stamentacount: { bank_account_id: @stamentacount.bank_account_id, company_id: @stamentacount.company_id, fecha1: @stamentacount.fecha1, fecha2: @stamentacount.fecha2, saldo_final: @stamentacount.saldo_final, saldo_inicial: @stamentacount.saldo_inicial, user_id: @stamentacount.user_id }
    assert_redirected_to stamentacount_path(assigns(:stamentacount))
  end

  test "should destroy stamentacount" do
    assert_difference('Stamentacount.count', -1) do
      delete :destroy, id: @stamentacount
    end

    assert_redirected_to stamentacounts_path
  end
end
