class OrdenComision < ActiveRecord::Base

  belongs_to :medio_customers
  belongs_to :orden_comision
  
 
  validates_presence_of :code,:name 
  
end
