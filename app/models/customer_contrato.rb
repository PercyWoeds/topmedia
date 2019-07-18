class CustomerContrato < ActiveRecord::Base
validates_presence_of :secu_cont, :customer_id, :contrato_id,:medio_id, :moneda_id 
  
  belongs_to :moneda
  
  has_many :customers 
  has_many :contratos
  has_many :medios
  


end
