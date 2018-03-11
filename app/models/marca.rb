class Marca < ActiveRecord::Base
  belongs_to :customer 
  
  has_many :productos
  has_many :versions, :through => :productos
  
  validates_presence_of :name,:customer_id
  
end
