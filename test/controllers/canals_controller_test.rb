require 'test_helper'

class CanalsControllerTest < ActionController::TestCase
  setup do
    @canal = canals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:canals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create canal" do
    assert_difference('Canal.count') do
      post :create, canal: { address1: @canal.address1, descrip: @canal.descrip, phone1: @canal.phone1, ruc: @canal.ruc }
    end

    assert_redirected_to canal_path(assigns(:canal))
  end

  test "should show canal" do
    get :show, id: @canal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @canal
    assert_response :success
  end

  test "should update canal" do
    patch :update, id: @canal, canal: { address1: @canal.address1, descrip: @canal.descrip, phone1: @canal.phone1, ruc: @canal.ruc }
    assert_redirected_to canal_path(assigns(:canal))
  end

  test "should destroy canal" do
    assert_difference('Canal.count', -1) do
      delete :destroy, id: @canal
    end

    assert_redirected_to canals_path
  end
end
