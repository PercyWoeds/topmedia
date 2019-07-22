class ContratoAbono < ActiveRecord::Base

  validates_presence_of :secu_cont, :customer_id ,:medio_id, :moneda_id 
  
  belongs_to :customer 
  belongs_to :medio
  belongs_to :moneda 


    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          ContratoAbono.create! row.to_hash 
        end
    end     

end
