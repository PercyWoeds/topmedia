class OrdenProduct < ActiveRecord::Base

    validates_presence_of :orden_id, :avisodetail_id, :price, :quantity, :tarifa, :total

	belongs_to :orden 
	belongs_to :avisodetail
  
  belongs_to :medio_detail
  
 # before_save :set_quantity 



    
    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row| 

          if row['d01'] == nil
           row['d01'] = 0
          end 
    	  if row['d02'] == nil
           row['d02'] = 0
          end 
          if row['d03'] == nil
           row['d03'] = 0
          end 
          if row['d04'] == nil
           row['d04'] = 0
          end 
          if row['d05'] == nil
           row['d05'] = 0
          end 
          if row['d06'] == nil
           row['d06'] = 0
          end 
          if row['d07'] == nil
           row['d07'] = 0
          end 
          if row['d08'] == nil
           row['d08'] = 0
          end 
          if row['d09'] == nil
           row['d09'] = 0
          end 
          if row['d10'] == nil
           row['d10'] = 0
          end 
          if row['d11'] == nil
           row['d11'] = 0
          end 
          if row['d12'] == nil
           row['d12'] = 0
          end 
          if row['d13'] == nil
           row['d13'] = 0
          end 
          if row['d14'] == nil
           row['d14'] = 0
          end 
          if row['d15'] == nil
           row['d15'] = 0
          end 
          if row['d16'] == nil
           row['d16'] = 0
          end 
          if row['d17'] == nil
           row['d17'] = 0
          end 
          if row['d18'] == nil
           row['d18'] = 0
          end 
          if row['d19'] == nil
           row['d19'] = 0
          end 
    	 if row['d20'] == nil
           row['d20'] = 0
          end 
          if row['d21'] == nil
           row['d21'] = 0
          end 
          if row['d22'] == nil
           row['d22'] = 0
          end 
          if row['d23'] == nil
           row['d23'] = 0
          end 
          if row['d24'] == nil
           row['d24'] = 0
          end 
          if row['d25'] == nil
           row['d25'] = 0
          end 
          if row['d26'] == nil
           row['d26'] = 0
          end 
          if row['d27'] == nil
           row['d27'] = 0
          end 
          if row['d28'] == nil
           row['d28'] = 0
          end 
          if row['d29'] == nil
           row['d29'] = 0
          end 
          if row['d30'] == nil
           row['d30'] = 0
          end 
          if row['d31'] == nil
           row['d31'] = 0
          end 

          
              	
	
          OrdenProduct.create! row.to_hash 
        end
    end      

  def set_quantity 
   

     self.quantity =(self.d01 + self.d02 + self.d03 + self.d04 +  self.d05 + self.d06 +  self.d07 +
                self.d08 + self.d09 + self.d10 + self.d11 +  self.d12 + self.d13 +  self.d14 +
                self.d15 + self.d16 + self.d17 + self.d18 +  self.d19 + self.d20 +  self.d21 +
                self.d22 + self.d23 + self.d24 + self.d25 +  self.d26 +  self.d27 + self.d28 + 
                self.d29 + self.d30 + self.d31 )
    self.total = self.price * self.quantity

    puts self.quantity 
    puts self.d25 

  end 

  def get_medio_details(id)

    @det = MedioDetail.where(medio_id: id )

    return @det 

  end 
  
end
