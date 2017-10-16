require 'test_helper'

class SupplierpaymentDetailsControllerTest < ActionController::TestCase
  setup do
    @supplierpayment_detail = supplierpayment_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:supplierpayment_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supplierpayment_detail" do
    assert_difference('SupplierpaymentDetail.count') do
      post :create, supplierpayment_detail: { descrip: @supplierpayment_detail.descrip, document_id: @supplierpayment_detail.document_id, documento: @supplierpayment_detail.documento, purchase_id: @supplierpayment_detail.purchase_id, supplier_id: @supplierpayment_detail.supplier_id, supplier_payment_id: @supplierpayment_detail.supplier_payment_id, tipocambio: @supplierpayment_detail.tipocambio, tm: @supplierpayment_detail.tm, total: @supplierpayment_detail.total }
    end

    assert_redirected_to supplierpayment_detail_path(assigns(:supplierpayment_detail))
  end

  test "should show supplierpayment_detail" do
    get :show, id: @supplierpayment_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @supplierpayment_detail
    assert_response :success
  end

  test "should update supplierpayment_detail" do
    patch :update, id: @supplierpayment_detail, supplierpayment_detail: { descrip: @supplierpayment_detail.descrip, document_id: @supplierpayment_detail.document_id, documento: @supplierpayment_detail.documento, purchase_id: @supplierpayment_detail.purchase_id, supplier_id: @supplierpayment_detail.supplier_id, supplier_payment_id: @supplierpayment_detail.supplier_payment_id, tipocambio: @supplierpayment_detail.tipocambio, tm: @supplierpayment_detail.tm, total: @supplierpayment_detail.total }
    assert_redirected_to supplierpayment_detail_path(assigns(:supplierpayment_detail))
  end

  test "should destroy supplierpayment_detail" do
    assert_difference('SupplierpaymentDetail.count', -1) do
      delete :destroy, id: @supplierpayment_detail
    end

    assert_redirected_to supplierpayment_details_path
  end
end
