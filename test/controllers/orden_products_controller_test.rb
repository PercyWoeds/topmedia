require 'test_helper'

class OrdenProductsControllerTest < ActionController::TestCase
  setup do
    @orden_product = orden_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orden_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orden_product" do
    assert_difference('OrdenProduct.count') do
      post :create, orden_product: {  }
    end

    assert_redirected_to orden_product_path(assigns(:orden_product))
  end

  test "should show orden_product" do
    get :show, id: @orden_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @orden_product
    assert_response :success
  end

  test "should update orden_product" do
    patch :update, id: @orden_product, orden_product: {  }
    assert_redirected_to orden_product_path(assigns(:orden_product))
  end

  test "should destroy orden_product" do
    assert_difference('OrdenProduct.count', -1) do
      delete :destroy, id: @orden_product
    end

    assert_redirected_to orden_products_path
  end
end
