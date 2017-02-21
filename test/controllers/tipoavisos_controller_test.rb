require 'test_helper'

class TipoavisosControllerTest < ActionController::TestCase
  setup do
    @tipoaviso = tipoavisos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipoavisos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipoaviso" do
    assert_difference('Tipoaviso.count') do
      post :create, tipoaviso: { comments: @tipoaviso.comments, descrip: @tipoaviso.descrip }
    end

    assert_redirected_to tipoaviso_path(assigns(:tipoaviso))
  end

  test "should show tipoaviso" do
    get :show, id: @tipoaviso
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipoaviso
    assert_response :success
  end

  test "should update tipoaviso" do
    patch :update, id: @tipoaviso, tipoaviso: { comments: @tipoaviso.comments, descrip: @tipoaviso.descrip }
    assert_redirected_to tipoaviso_path(assigns(:tipoaviso))
  end

  test "should destroy tipoaviso" do
    assert_difference('Tipoaviso.count', -1) do
      delete :destroy, id: @tipoaviso
    end

    assert_redirected_to tipoavisos_path
  end
end
