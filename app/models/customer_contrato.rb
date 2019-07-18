class CustomerContrato < ActiveRecord::Base
validates_presence_of :secu_cont, :customer_id, :contrato_id,:medio_id, :moneda_id 
  
  belongs_to :customer 
  belongs_to :medio
  belongs_to :contrato 
  belongs_to :moneda 

end
