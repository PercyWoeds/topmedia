class CustomerContrato < ActiveRecord::Base
validates_presence_of :secu_cont, :customer_id, :contrato_id,:medio_id, :moneda_id 
  
  belongs_to :customer 
  belongs_to :medio
  belongs_to :contrato 
  belongs_to :moneda 



    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          CustomerContrato.create! row.to_hash 
        end
    end      

	def generate_orden(customer)
	    if CustomerContrato.where("customer_id = ?",customer).maximum("cast(secu_cont  as int)") == nil 
	      self.secu_cont = "001"
	    else
	      self.secu_cont = CustomerContrato.where("customer_id = ?",customer).maximum("cast(secu_cont  as int)").next.to_s.rjust(3, '0') 
	          
	    end 
	    
	end


end
