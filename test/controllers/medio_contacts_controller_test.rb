require 'test_helper'

class MedioContactsControllerTest < ActionController::TestCase
  setup do
    @medio_contact = medio_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:medio_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medio_contact" do
    assert_difference('MedioContact.count') do
      post :create, medio_contact: { anexo1: @medio_contact.anexo1, anexo2: @medio_contact.anexo2, anexo3: @medio_contact.anexo3, cargo: @medio_contact.cargo, celular1: @medio_contact.celular1, celular2: @medio_contact.celular2, celular3: @medio_contact.celular3, code: @medio_contact.code, correo1: @medio_contact.correo1, correo2: @medio_contact.correo2, medios: @medio_contact.medios, name: @medio_contact.name, references: @medio_contact.references, telefon1: @medio_contact.telefon1, telefono2: @medio_contact.telefono2, telefono3: @medio_contact.telefono3 }
    end

    assert_redirected_to medio_contact_path(assigns(:medio_contact))
  end

  test "should show medio_contact" do
    get :show, id: @medio_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @medio_contact
    assert_response :success
  end

  test "should update medio_contact" do
    patch :update, id: @medio_contact, medio_contact: { anexo1: @medio_contact.anexo1, anexo2: @medio_contact.anexo2, anexo3: @medio_contact.anexo3, cargo: @medio_contact.cargo, celular1: @medio_contact.celular1, celular2: @medio_contact.celular2, celular3: @medio_contact.celular3, code: @medio_contact.code, correo1: @medio_contact.correo1, correo2: @medio_contact.correo2, medios: @medio_contact.medios, name: @medio_contact.name, references: @medio_contact.references, telefon1: @medio_contact.telefon1, telefono2: @medio_contact.telefono2, telefono3: @medio_contact.telefono3 }
    assert_redirected_to medio_contact_path(assigns(:medio_contact))
  end

  test "should destroy medio_contact" do
    assert_difference('MedioContact.count', -1) do
      delete :destroy, id: @medio_contact
    end

    assert_redirected_to medio_contacts_path
  end
end
