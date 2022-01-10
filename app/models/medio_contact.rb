class MedioContact < ActiveRecord::Base
   belongs_to :medio

   
   attr_accessible :code, :name ,:cargo, :telefono1, :telefono2, :telefono3, :anexo1, :anexo2,
       :anexo3, :celular1, :celular2, :celular3, :correo1, :correo2,:medio_id, :medio_contacts_attributes
  
end
