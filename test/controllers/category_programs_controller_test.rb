require 'test_helper'

class CategoryProgramsControllerTest < ActionController::TestCase
  setup do
    @category_program = category_programs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:category_programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category_program" do
    assert_difference('CategoryProgram.count') do
      post :create, category_program: { code: @category_program.code, descrip: @category_program.descrip }
    end

    assert_redirected_to category_program_path(assigns(:category_program))
  end

  test "should show category_program" do
    get :show, id: @category_program
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category_program
    assert_response :success
  end

  test "should update category_program" do
    patch :update, id: @category_program, category_program: { code: @category_program.code, descrip: @category_program.descrip }
    assert_redirected_to category_program_path(assigns(:category_program))
  end

  test "should destroy category_program" do
    assert_difference('CategoryProgram.count', -1) do
      delete :destroy, id: @category_program
    end

    assert_redirected_to category_programs_path
  end
end
