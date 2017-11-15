class Medio < ActiveRecord::Base

	
	belongs_to :contrato 
	belongs_to :orden
	
		def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Avisodetail.create! row.to_hash 
        end
    end      
	
end
