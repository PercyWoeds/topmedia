require 'test_helper'

class StamentacountDetailsControllerTest < ActionController::TestCase
  setup do
    @stamentacount_detail = stamentacount_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stamentacount_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stamentacount_detail" do
    assert_difference('StamentacountDetail.count') do
      post :create, stamentacount_detail: { abono: @stamentacount_detail.abono, cargo: @stamentacount_detail.cargo, concepto: @stamentacount_detail.concepto, fecha: @stamentacount_detail.fecha, nrocheque: @stamentacount_detail.nrocheque, tipomov_id: @stamentacount_detail.tipomov_id }
    end

    assert_redirected_to stamentacount_detail_path(assigns(:stamentacount_detail))
  end

  test "should show stamentacount_detail" do
    get :show, id: @stamentacount_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stamentacount_detail
    assert_response :success
  end

  test "should update stamentacount_detail" do
    patch :update, id: @stamentacount_detail, stamentacount_detail: { abono: @stamentacount_detail.abono, cargo: @stamentacount_detail.cargo, concepto: @stamentacount_detail.concepto, fecha: @stamentacount_detail.fecha, nrocheque: @stamentacount_detail.nrocheque, tipomov_id: @stamentacount_detail.tipomov_id }
    assert_redirected_to stamentacount_detail_path(assigns(:stamentacount_detail))
  end

  test "should destroy stamentacount_detail" do
    assert_difference('StamentacountDetail.count', -1) do
      delete :destroy, id: @stamentacount_detail
    end

    assert_redirected_to stamentacount_details_path
  end
end
