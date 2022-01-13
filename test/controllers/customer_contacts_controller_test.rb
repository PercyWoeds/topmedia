require 'test_helper'

class CustomerContactsControllerTest < ActionController::TestCase
  setup do
    @customer_contact = customer_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_contact" do
    assert_difference('CustomerContact.count') do
      post :create, customer_contact: { anexo1: @customer_contact.anexo1, anexo2: @customer_contact.anexo2, anexo3: @customer_contact.anexo3, cargo: @customer_contact.cargo, celular1: @customer_contact.celular1, celular2: @customer_contact.celular2, celular3: @customer_contact.celular3, code: @customer_contact.code, contacto_id: @customer_contact.contacto_id, correo1: @customer_contact.correo1, correo2: @customer_contact.correo2, name: @customer_contact.name, telefono1: @customer_contact.telefono1, telefono2: @customer_contact.telefono2, telefono3: @customer_contact.telefono3, user_id: @customer_contact.user_id }
    end

    assert_redirected_to customer_contact_path(assigns(:customer_contact))
  end

  test "should show customer_contact" do
    get :show, id: @customer_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_contact
    assert_response :success
  end

  test "should update customer_contact" do
    patch :update, id: @customer_contact, customer_contact: { anexo1: @customer_contact.anexo1, anexo2: @customer_contact.anexo2, anexo3: @customer_contact.anexo3, cargo: @customer_contact.cargo, celular1: @customer_contact.celular1, celular2: @customer_contact.celular2, celular3: @customer_contact.celular3, code: @customer_contact.code, contacto_id: @customer_contact.contacto_id, correo1: @customer_contact.correo1, correo2: @customer_contact.correo2, name: @customer_contact.name, telefono1: @customer_contact.telefono1, telefono2: @customer_contact.telefono2, telefono3: @customer_contact.telefono3, user_id: @customer_contact.user_id }
    assert_redirected_to customer_contact_path(assigns(:customer_contact))
  end

  test "should destroy customer_contact" do
    assert_difference('CustomerContact.count', -1) do
      delete :destroy, id: @customer_contact
    end

    assert_redirected_to customer_contacts_path
  end
end
