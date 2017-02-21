require 'test_helper'

class AvisodetailsControllerTest < ActionController::TestCase
  setup do
    @avisodetail = avisodetails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:avisodetails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create avisodetail" do
    assert_difference('Avisodetail.count') do
      post :create, avisodetail: { comments: @avisodetail.comments, descrip: @avisodetail.descrip }
    end

    assert_redirected_to avisodetail_path(assigns(:avisodetail))
  end

  test "should show avisodetail" do
    get :show, id: @avisodetail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @avisodetail
    assert_response :success
  end

  test "should update avisodetail" do
    patch :update, id: @avisodetail, avisodetail: { comments: @avisodetail.comments, descrip: @avisodetail.descrip }
    assert_redirected_to avisodetail_path(assigns(:avisodetail))
  end

  test "should destroy avisodetail" do
    assert_difference('Avisodetail.count', -1) do
      delete :destroy, id: @avisodetail
    end

    assert_redirected_to avisodetails_path
  end
end
