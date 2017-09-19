class OrdenProduct < ActiveRecord::Base

    validates_presence_of :orden_id, :avisodetail_id, :price, :quantity, :tarifa, :total

	belongs_to :orden 
	belongs_to :avisodetail 

    
end
