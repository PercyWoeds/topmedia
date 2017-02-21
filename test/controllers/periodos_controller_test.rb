require 'test_helper'

class PeriodosControllerTest < ActionController::TestCase
  setup do
    @periodo = periodos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:periodos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create periodo" do
    assert_difference('Periodo.count') do
      post :create, periodo: { comments: @periodo.comments, descrip: @periodo.descrip }
    end

    assert_redirected_to periodo_path(assigns(:periodo))
  end

  test "should show periodo" do
    get :show, id: @periodo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @periodo
    assert_response :success
  end

  test "should update periodo" do
    patch :update, id: @periodo, periodo: { comments: @periodo.comments, descrip: @periodo.descrip }
    assert_redirected_to periodo_path(assigns(:periodo))
  end

  test "should destroy periodo" do
    assert_difference('Periodo.count', -1) do
      delete :destroy, id: @periodo
    end

    assert_redirected_to periodos_path
  end
end
