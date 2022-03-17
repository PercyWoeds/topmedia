class OrdenComision < ActiveRecord::Base

  belongs_to :medio_customers
  
 
  validates_presence_of :code,:name 
  
end
