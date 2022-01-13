class CustomerContact < ActiveRecord::Base

belongs_to :customer 

   
   attr_accessible :code, :name ,:cargo, :telefono1, :telefono2, :telefono3, :anexo1, :anexo2,
       :anexo3, :celular1, :celular2, :celular3, :correo1, :correo2,:medio_id, :customer_contacts_attributes
  
end
