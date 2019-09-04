class OrdenProduct < ActiveRecord::Base

    validates_presence_of :orden_id, :avisodetail_id, :price, :quantity, :tarifa, :total

	belongs_to :orden 
	belongs_to :avisodetail


    
    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row| 	
	
          OrdenProduct.create! row.to_hash 
        end
    end      


end
