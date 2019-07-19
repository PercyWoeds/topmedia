class ContratoAbono < ActiveRecord::Base

  validates_presence_of :secu_cont, :customer_id ,:medio_id, :moneda_id 
  
  belongs_to :customer 
  belongs_to :medio
  belongs_to :moneda 


end
