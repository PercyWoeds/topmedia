class ContratoDetail < ActiveRecord::Base
    validates_presence_of :importe ,:nro ,:fecha 
    
    belongs_to :contrato 
    has_many :factura_detail
    
    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          ContratoDetail.create! row.to_hash 
        end
    end      

    def get_sit
    	if self.sit,nil?
    		return  ""
       else
       		return "Cancelado"
       end 
       	
    end 
    
end
