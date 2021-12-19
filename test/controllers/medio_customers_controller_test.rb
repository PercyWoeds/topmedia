require 'test_helper'

class MedioCustomersControllerTest < ActionController::TestCase
  setup do
    @medio_customer = medio_customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:medio_customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medio_customer" do
    assert_difference('MedioCustomer.count') do
      post :create, medio_customer: { comision1: @medio_customer.comision1, comision2: @medio_customer.comision2, customer_id: @medio_customer.customer_id, medio_id: @medio_customer.medio_id }
    end

    assert_redirected_to medio_customer_path(assigns(:medio_customer))
  end

  test "should show medio_customer" do
    get :show, id: @medio_customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @medio_customer
    assert_response :success
  end

  test "should update medio_customer" do
    patch :update, id: @medio_customer, medio_customer: { comision1: @medio_customer.comision1, comision2: @medio_customer.comision2, customer_id: @medio_customer.customer_id, medio_id: @medio_customer.medio_id }
    assert_redirected_to medio_customer_path(assigns(:medio_customer))
  end

  test "should destroy medio_customer" do
    assert_difference('MedioCustomer.count', -1) do
      delete :destroy, id: @medio_customer
    end

    assert_redirected_to medio_customers_path
  end
end
