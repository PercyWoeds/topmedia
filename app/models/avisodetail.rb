class Avisodetail < ActiveRecord::Base

    validates_presence_of :category_program_id,:descrip 
    
    belongs_to :category_program

	has_many :orden_products

    
	def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Avisodetail.create! row.to_hash 
        end
    end      

end
