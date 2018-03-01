class Medio < ActiveRecord::Base
    validates_uniqueness_of :estacion 
	validates_presence_of :descrip,:grupo,:estacion
	
	before_save :set_full_name
	
	belongs_to :contrato 
	belongs_to :orden
	
	def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Avisodetail.create! row.to_hash 
        end
    end      
    
    def set_full_name
		self.full_name ="#{self.descrip} #{self.estacion} #{self.grupo} ".strip		
	end 
	
   	def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Medio.create! row.to_hash 
        end
    end   
    
  def self.to_csv
    attributes = %w{id descrip ruc grupo estacion }

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |medio|
        csv << attributes.map{ |attr| medio.send(attr) }
      end
    end
  end
  
end
